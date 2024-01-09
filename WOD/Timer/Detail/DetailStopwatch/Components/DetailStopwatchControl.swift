//
//  DetailStopwatchControl.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI

// MARK: - DetailStopwatchControl
struct DetailStopwatchControl: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel

    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // before
            ControlButton(isPaused: $viewModel.controlBtn ,action: viewModel.controlBack, defaultImgName: "chevron.left.to.line")
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.3)
                    .foregroundColor(.secondary)
                
                // start / pause
                if viewModel.detailRoundPhase != .completed {
                    ControlButton(isPaused: $viewModel.controlBtn, action: viewModel.controlSwPausedOrResumed,
                                  img1Name: "play.fill",
                                  img2Name: "pause.fill")
                }
            } // ZStack
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.3)
                    .foregroundColor(.secondary)
                
                // check & and
                ControlButton(isPaused: $viewModel.controlBtn, action: viewModel.controlStopwatchCheck, defaultImgName: "checkmark")
            } // ZStack
            
        } // HStack
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // body
}

struct DetailStopwatchControl_Previews: PreviewProvider {
    static var previews: some View {
        DetailStopwatchControl()
            .environmentObject(DetailViewModel.shared)
    }
}
