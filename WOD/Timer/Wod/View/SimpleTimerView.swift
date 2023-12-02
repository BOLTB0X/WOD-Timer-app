//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

struct SimpleTimerView: View {
    @EnvironmentObject private var viewModel: WodViewModel
    @Binding var isBackRootView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                // 배경색
                viewModel.phaseBackgroundColor
                
                // MARK: - main
                VStack(alignment: .center, spacing: 10) {
                    Text(viewModel.currentRoundDisplay)
                        .font(.system(size: 50, weight: .bold))
                        .fontWeight(.bold)
                        .padding()
                    
                    
                    // MARK: 현재 타이머
                    VStack(alignment: .center, spacing: 0) {
                        Text(viewModel.currentPhaseText)
                            .font(.system(size: 20, weight: .semibold))
                            .padding()
                        
                        // 현재 라운드의 진행 중인 타이머 시간 표시
                        Text(viewModel.currentDisplayTime)
                            .font(
                                .system(size: viewModel.selectedMovementAmount.timerBigFontSize, weight: .heavy)
                            )
                            
                    }
                    
                    // MARK: 다음 타이머
                    VStack(alignment: .center, spacing: 0) {
                        Text(viewModel.nextTimerPhase)
                            .font(.system(size: 15, weight: .regular))
                            .padding()
                        
                        Text(viewModel.nextTimerTime)
                            .font(
                                .system(size: viewModel.selectedMovementAmount.timerSmallFontSize, weight: .bold)
                            )
                    }
                    .foregroundColor(.secondary)
                }
                
                
                // MARK: - side
                .navigationTitle("\(viewModel.simpleTotalTime.asTimestamp)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isBackRootView.toggle()
                        }) {
                            if viewModel.simpleRoundIdx ?? 0 == viewModel.selectedRoundAmount {
                                Image(systemName: "arrow.backward")
                            }
                        }.buttonStyle(EffectButtonStyle())
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.simpleRestart()
                        }) {
                            if viewModel.simpleRoundIdx ?? 0 == viewModel.selectedRoundAmount {
                                Image(systemName: "arrow.clockwise")
                            }
                        }.buttonStyle(EffectButtonStyle())
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.nextSimpleRound()
        }
    }
}

#Preview {
    SimpleTimerView(isBackRootView: .constant(true))
        .environmentObject(WodViewModel())
}
