//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

// MARK: - SimpleTimerView
struct SimpleTimerView: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    @Binding var isBackRootView: Bool
    var avManger = AVManager.shared
    
    var body: some View {
        NavigationView {
            // MARK: - View Main
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                // MARK: displayTime
                displayTime()
                
                Spacer()
                
                Divider()

                // MARK: SimpleTimerControl
                SimpleTimerControl()
                    .environmentObject(viewModel)
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
                        viewModel.simpleTimerCanclled()
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
            viewModel.nextSimpleTimerRound()
        }
    } // body
    
    // MARK: - ViewBuilder
    // ..
    // MARK: - main
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
            
            SimpleNextRealTime()
                .environmentObject(viewModel)
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
        } // VStack
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    } // displayTime
}

struct SimpleTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTimerView(isBackRootView: .constant(true))
            .environmentObject(SimpleViewModel())
    }
}
