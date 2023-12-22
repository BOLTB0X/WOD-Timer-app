//
//  SimpleTimerDisplayTime.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI

// MARK: - SimpleTimerDisplayTime
struct SimpleTimerDisplayTime: View {
    @EnvironmentObject private var viewModel: SimpleViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            // 현재 라운드
            
            Button(action: {
                viewModel.speakingProcessingRound()
            }) {
                Text(viewModel.currentTimerRoundDisplay)
                    .font(.system(size: 60, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            } // Button
            .padding()
            
            
            SimpleRealTime()
                .environmentObject(viewModel)
                .padding()
            
            SimpleNextRealTime()
                .environmentObject(viewModel)
                .padding()
            
            Button(action: {
                viewModel.speakingRemainingRound()
            }) {
                Text(viewModel.currentTimerRemainingRounds)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(viewModel.isTmEnd)
                    .padding()
            } // Button
            
            Spacer()
        } // VStack
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    }
}

struct SimpleTimerDisplayTime_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTimerDisplayTime()
            .environmentObject(SimpleViewModel.shared)
    }
}
