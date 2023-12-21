//
//  SimpleStopwatchDisplayTime.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI

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
            
            Spacer()
                .frame(maxWidth: .infinity , maxHeight: .infinity)
        } // VStack
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    }
}

struct SimpleStopwatchDisplayTime_Previews: PreviewProvider {
    static var previews: some View {
        SimpleStopwatchDisplayTime()
            .environmentObject(SimpleViewModel.shared)
    }
}

