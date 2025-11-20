//
//  SimpleStopwatchControl.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleStopwatchControl
struct SimpleStopwatchControl: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: SimpleViewModel
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ControlButton(isPaused: $viewModel.controlBtn ,action: viewModel.controlBack, defaultImgName: "chevron.left.to.line")

            
            ZStack {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                // start / pause
                if viewModel.simpleRoundPhase != .completed {
                    ControlButton(isPaused: $viewModel.controlBtn, action:  viewModel.controlSwPausedOrResumed,
                                  img1Name: "play.fill",
                                  img2Name: "pause.fill")
                }
            } // ZStack
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                // check & and
                ControlButton(isPaused: $viewModel.controlBtn, action: viewModel.controlStopwatchCheck, defaultImgName: "checkmark")
            } // ZStack
        } // HStack
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onOpenURL { url in
            guard let action = url.host else { return }
            
            switch action {
            case "stopResume":
                // 타이머 정지 또는 재개 로직 수행
                viewModel.controlSwPausedOrResumed()
            case "next":
                // 다음 동작 로직 수행
                viewModel.controlStopwatchCheck()
            case "before":
                // 이전 동작 로직 수행
                viewModel.controlBack()
            default:
                break
            }
        }
    }
}
//
//struct SimpleStopwatchControl_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleStopwatchControl()
//            .environmentObject(SimpleViewModel())
//    }
//}

