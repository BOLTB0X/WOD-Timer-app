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
        HStack(alignment: .center, spacing: 50) {
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
    }
}

struct SimpleStopwatchControl_Previews: PreviewProvider {
    static var previews: some View {
        SimpleStopwatchControl()
            .environmentObject(SimpleViewModel())
    }
}

