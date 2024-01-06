//
//  DetailTimerDisplayTime.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/01/04.
//

import SwiftUI

// MARK: - DetailTimerDisplayTime
struct DetailTimerDisplayTime: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: - View
    var body: some View {
        // MARK: main
        VStack(alignment: .center, spacing: 10) {
            // 현재 라운드
            
            Button(action: {
//                viewModel.speakingProcessingRound()
            }) {
                Text(viewModel.currentTimerRoundDisplay)
                    .font(.system(size: 60, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            } // Button
            .padding()
            
            
            DetailRealTime()
                .environmentObject(viewModel)
                .padding()
            
            DetailNextRealTime()
                .environmentObject(viewModel)
                .padding()
            
            Button(action: {
                //viewModel.speakingRemainingRound()
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

struct DetailTimerDisplayTime_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerDisplayTime()
            .environmentObject(DetailViewModel.shared)
    }
}
