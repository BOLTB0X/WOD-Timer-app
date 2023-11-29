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
        VStack(alignment: .center, spacing: 16) {
            // 현재 라운드 정보
            Text("Round \(viewModel.currentRoundIndex + 1)")
                .font(.title)
                .fontWeight(.bold)

            // 현재 라운드의 진행 중인 타이머 시간 표시
            RealTimeView(time: viewModel.displayCurrentPhase(), fontSize: 24)

//            // 남은 전체 시간
//            RealTimeView(time: viewModel.simpleRounds[viewModel.currentRoundIndex].totalTime.asTimestamp, fontSize: 32)

            // 버튼으로 타이머 상태 제어
            HStack(spacing: 16) {
                Button(action: {
                    viewModel.pauseTimer()
                }) {
                    Text("Pause")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                }

                Button(action: {
                    viewModel.resumeTimer()
                }) {
                    Text("Resume")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 16)
        }
        .padding()
        .onAppear {
            viewModel.startSimpleRoutine()
        }
    }
}


#Preview {
    SimpleTimerView()
        .environmentObject(WodViewModel())
}
