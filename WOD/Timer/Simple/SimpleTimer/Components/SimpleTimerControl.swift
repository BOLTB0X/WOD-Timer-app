//
//  SimpleTimerControl.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleTimerControl
struct SimpleTimerControl: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: SimpleViewModel

    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // before
            ControlButton(isPaused: $viewModel.controlBtn ,action: viewModel.controlBefore, defaultImgName: "chevron.left.2")
            
            // start / pause
            ZStack {
                CircularProgress(progress: $viewModel.simpleUnitProgress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if viewModel.simpleRoundPhase != .completed {
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

struct SimpleTimerControl_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTimerControl()
            .environmentObject(SimpleViewModel())
    }
}
