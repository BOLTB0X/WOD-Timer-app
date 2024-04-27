//
//  DetailTimerControl.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/01/04.
//

import SwiftUI

// MARK: - DetailTimerControl
struct DetailTimerControl: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel

    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // before
            ControlButton(isPaused: $viewModel.controlBtn ,action: viewModel.controlBefore, defaultImgName: "chevron.left.2")
            
            // start / pause
            ZStack {
                CircularProgress(progress: $viewModel.detailUnitProgress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if viewModel.detailRoundPhase != .completed {
                    ControlButton(isPaused: $viewModel.controlBtn, action:  viewModel.controlTmPausedOrResumed,
                                  img1Name: "play.fill",
                                  img2Name: "pause.fill")
                }
            } // ZStack
            
            // next
            ControlButton(isPaused: $viewModel.controlBtn, action: viewModel.controlNext, defaultImgName: "chevron.right.2")
        } // HStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onOpenURL { url in
            guard let action = url.host else { return }
            
            switch action {
            case "stopResume":
                // 타이머 정지 또는 재개 로직 수행
                viewModel.controlTmPausedOrResumed()
            case "next":
                // 다음 동작 로직 수행
                viewModel.controlNext()
            case "before":
                // 이전 동작 로직 수행
                viewModel.controlBefore()
            default:
                break
            }
        }
    } // body
}

struct DetailTimerControl_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerControl()
            .environmentObject(DetailViewModel.shared)
    }
}
