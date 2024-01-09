//
//  DetailStopwatchDisplayTime.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI

// MARK: - DetailStopwatchDisplayTime
struct DetailStopwatchDisplayTime: View {
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
                Text(viewModel.currentStopRoundDisplay)
                    .font(.system(size: 60, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            } // Button
            .padding()
            
            DetailRealTime(
                currentTitle: viewModel.currentStopwatchTitle,
                currentDisplayTime: viewModel.currentStopDisplayTime, 
                bigFontSize: viewModel.selectedMovementAmount.timerBigFontSize
            )
            .padding()
            
            Text(viewModel.nextStopPhase)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(viewModel.isTmEnd)
                .padding()
            
            Button(action: {
                //viewModel.speakingRemainingRound()
            }) {
                Text(viewModel.currentStopRemainingRounds)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(viewModel.isTmEnd)
                    .padding()
            } // Button
            .padding()
            
            Spacer()
            
        } // VStack
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    } // body
}
