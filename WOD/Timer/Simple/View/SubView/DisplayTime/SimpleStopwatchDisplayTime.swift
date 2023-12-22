//
//  SimpleStopwatchDisplayTime.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI

// MARK: - SimpleStopwatchDisplayTime
struct SimpleStopwatchDisplayTime: View {
    @EnvironmentObject private var viewModel: SimpleViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            // 현재 라운드
            
            Button(action: {
                viewModel.speakingProcessingRound()
            }) {
                Text(viewModel.currentStopRoundDisplay)
                    .font(.system(size: 60, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            } // Button
            .padding()
            
            
            SimpleRealTime()
                .environmentObject(viewModel)
                .padding()
            
            VStack(alignment: .center, spacing: 0) {
                Text(viewModel.nextStopPhase)
                    .font(.system(size: 24, weight: .regular))

            }
            .foregroundColor(viewModel.isSwEnd)
            .padding()

            Button(action: {
                viewModel.speakingRemainingRound()
            }) {
                Text(viewModel.currentStopRemainingRounds)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(viewModel.isSwEnd)
                    .padding()
            } // Button
            
            Text("Do it yourself")
                .font(.system(size: 40, weight: .bold))
                .padding()

        } // VStack
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    } // body
}

