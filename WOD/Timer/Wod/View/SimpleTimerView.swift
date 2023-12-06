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
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                // MARK: main
                VStack(alignment: .center, spacing: 10) {
                    // 현재 라운드
                    Text(viewModel.currentRoundDisplay)
                        .font(.system(size: 60, weight: .bold))
                        .fontWeight(.bold)
                    .padding()
                    
                    
                    SimpleRealTime()
                        .environmentObject(viewModel)
                    .padding()
                    
                    SimpleNextRealTime()
                        .environmentObject(viewModel)
                    .padding()
                    
                    Text(viewModel.currentRemainingRounds)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(viewModel.simpleRoundIdx ?? 0 < viewModel.simpleRounds.count ? .secondary : viewModel.phaseBackgroundColor)
                        .padding()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity , maxHeight: .infinity)
                .background(viewModel.phaseBackgroundColor)
                                
                SimpleControl()
                    .environmentObject(viewModel)
            }
            
            // MARK: - side
            .navigationTitle(Text("\(viewModel.simpleTotalTime.asTimestamp)").bold())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: 왼쪽 뒤로가기
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.simpleRoundIdx = nil
                        isBackRootView.toggle()
                    }) {
                        if viewModel.simpleState == .paused || viewModel.simpleRoundIdx ?? 0 == viewModel.selectedRoundAmount {
                            Image(systemName: "arrow.backward")
                        }
                    }.buttonStyle(EffectButtonStyle())
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.simpleRestart()
                    }) {
                        if viewModel.simpleState == .paused || viewModel.simpleRoundIdx ?? 0 == viewModel.selectedRoundAmount {
                            Image(systemName: "arrow.clockwise")
                        }
                    }.buttonStyle(EffectButtonStyle())
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
