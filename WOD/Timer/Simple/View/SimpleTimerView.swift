//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

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
                
                // MARK: control
                control()
            }
            
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
                        viewModel.simpleCanclled()
                        isBackRootView.toggle()
                    }, condition: viewModel.isDisplayToolbarBtn, systemName: "arrow.backward")
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButton(action: viewModel.simpleRestart, condition: viewModel.isDisplayToolbarBtn, systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear {
            viewModel.nextSimpleRound()
        }
    }
    
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
            }
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
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(viewModel.phaseBackgroundColor)
    }
    
    // MARK: - control
    @ViewBuilder
    private func control() -> some View {
        HStack(alignment: .center, spacing: 10) {
            // before
            ControlButton(isPaused: $viewModel.controlBtn ,action: viewModel.controlBefore, defaultImgName: "chevron.left.2")
            
            // start / pause
            ZStack {
                CircularProgress(progress: $viewModel.simpleUnitProgress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if viewModel.simpleRoundPhase != .completed {
                    ControlButton(isPaused: $viewModel.controlBtn, action:  viewModel.controlPausedOrResumed,
                                  img1Name: "play.fill",
                                  img2Name: "pause.fill")
                }
            }
            
            // next
            ControlButton(isPaused: $viewModel.controlBtn, action: viewModel.controlNext, defaultImgName: "chevron.right.2")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SimpleTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTimerView(isBackRootView: .constant(true))
            .environmentObject(SimpleViewModel())
    }
}
