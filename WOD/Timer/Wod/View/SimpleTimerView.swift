//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

struct SimpleTimerView: View {
    @EnvironmentObject private var viewModel: WodViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                viewModel.phaseBackgroundColor
                    .ignoresSafeArea(.all, edges: .bottom)
                
                VStack(alignment: .center, spacing: 10) {
                    Text("\((viewModel.simpleRoundIdx ?? 0) + 1) Round")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    

                    // MARK: 현재 타이머
                    VStack(alignment: .center, spacing: 0) {
                        Text("Current: \(viewModel.simpleRoundPhase?.phaseText ?? "")")
                            .font(.system(size: 20, weight: .semibold))
                            .padding()
                        
                        // 현재 라운드의 진행 중인 타이머 시간 표시
                        Text(viewModel.simpleDisplay.asTimestamp)
                            .font(
                                .system(size: viewModel.selectedMovementAmount.hours > 0 ? 88 : 120, weight: .heavy)
                            )
                    }
                    
                    // MARK: 다음 타이머
                    VStack(alignment: .center, spacing: 0) {
                        Text(viewModel.nextTimerPhase)
                            .font(.system(size: 15, weight: .regular))
                            .padding()
                        
                        Text(viewModel.nextTimerTime)
                            .font(
                                .system(size: viewModel.selectedMovementAmount.hours > 0 ? 44 : 50, weight: .bold)
                            )
                    }.foregroundColor(.secondary)
                }
                
                .navigationTitle("\(viewModel.simpleTotalTime.asTimestamp)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                        }) {
                            Image(systemName: "gear")
                        }
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
    SimpleTimerView()
        .environmentObject(WodViewModel())
}
