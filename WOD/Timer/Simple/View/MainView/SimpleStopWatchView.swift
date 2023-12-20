//
//  SimpleStopWatchView.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleStopWatchView
struct SimpleStopWatchView: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    @Binding var isBackRootView: Bool
    
    var avManger = AVManager.shared
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                // MARK: displayTime
                displayTime()
                
                Spacer()
                
                Divider()
                
                // MARK: SimpleStopwatchControl
//                SimpleStopwatchControl()
                    //.environmentObject(viewModel)
                
            } // VStack
            
            // MARK: - side
            .navigationTitle(
                Text("\(viewModel.simpleTotalTime.asTimestamp)")
                    .bold()
                    .foregroundColor(.black))
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                // MARK: 왼쪽 뒤로가기
                ToolbarItem(placement: .navigationBarLeading) {
                    ToolbarButton(action: {
                        isBackRootView.toggle()
                    }, condition: viewModel.isDisplayToolbarBtn, systemName: "arrow.backward")
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButton(action: viewModel.simpleTimerRestart, condition: viewModel.isDisplayToolbarBtn, systemName: "arrow.clockwise")
                }
            } // toolbar
        } // NavigationView
        .onAppear {
            viewModel.nextSimpleStopwatchRound()
        }
    } // body
    
    // MARK: - ViewBuilder
    // ...
    // MARK: - displayTime
    @ViewBuilder
    private func displayTime() -> some View {
        VStack(alignment: .center, spacing: 10) {
            // 현재 라운드
            
            Button(action: {
                viewModel.speakingProcessingRound()
            }) {
                Text(viewModel.currentRoundDisplay)
                    .font(.system(size: 60, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            } // Button
            .padding()
            
            
            SimpleRealTime()
                .environmentObject(viewModel)
                .padding()
            
            VStack(alignment: .center, spacing: 0) {
                Text(viewModel.nextTimerPhase)
                    .font(.system(size: 24, weight: .regular))

            }
            .foregroundColor(viewModel.isEnd)
            .padding()

            Button(action: {
                viewModel.speakingRemainingRound()
            }) {
                Text(viewModel.currentRemainingRounds)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(viewModel.isEnd)
                    .padding()
            } // Button
            
            Spacer()
                .frame(maxWidth: .infinity , maxHeight: .infinity)
        } // VStack
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    } // displayTime
}

struct SimpleStopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleStopWatchView(isBackRootView: .constant(true))
            .environmentObject(SimpleViewModel())
    }
}

