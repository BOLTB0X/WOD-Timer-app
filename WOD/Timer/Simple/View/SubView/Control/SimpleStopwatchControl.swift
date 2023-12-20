//
//  SimpleStopwatchControl.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleStopwatchControl
struct SimpleStopwatchControl: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // before
            ControlButton(isPaused: $viewModel.controlBtn ,action: viewModel.controlBefore, defaultImgName: "chevron.left.2")
            
            // start / pause
            
            if viewModel.simpleRoundPhase != .completed {
                ControlButton(isPaused: $viewModel.controlBtn, action:  viewModel.controlTmPausedOrResumed,
                              img1Name: "play.fill",
                              img2Name: "pause.fill")
            }
            
            // next
            ControlButton(isPaused: $viewModel.controlBtn, action: viewModel.controlNext, defaultImgName: "chevron.right.2")
        } // HStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SimpleStopwatchControl_Previews: PreviewProvider {
    static var previews: some View {
        SimpleStopwatchControl()
            .environmentObject(SimpleViewModel())
    }
}

