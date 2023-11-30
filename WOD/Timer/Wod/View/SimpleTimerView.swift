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
        VStack(alignment: .center, spacing: 10) {
            // 현재 라운드 정보
//            Text("\(viewModel.simpleTotalTime - viewModel.simpleDisplay) / \(viewModel.simpleTotalTime)")
//            .font(.title)
//            .fontWeight(.bold)

            
            if viewModel.simpleRoundIdx ?? 0 < viewModel.simpleRounds.count {
                Text("\(viewModel.simpleTotalTime)")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Round \((viewModel.simpleRoundIdx ?? 0) + 1)")
                    .font(.title)
                    .fontWeight(.bold)
                Text(viewModel.simpleRoundPhase?.phaseText ?? "")
                    .font(.subheadline)
               // 현재 라운드의 진행 중인 타이머 시간 표시
                
                Text(viewModel.simpleDisplay.asTimestamp)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(
                        .system(size: 80)
                        .weight(.bold)
                        //.monospacedDigit()
                    )
            } else {
                Text("완료")
            }
//            RealTimeView(time: viewModel.simpleDisplay.asTimestamp, fontSize: 80)
        }
        .padding()
        .onAppear {
            viewModel.moveToNextRound()
        }
    }
}

#Preview {
    SimpleTimerView()
        .environmentObject(WodViewModel())
}
