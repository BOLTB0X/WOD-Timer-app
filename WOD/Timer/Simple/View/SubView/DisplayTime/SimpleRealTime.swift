//
//  SimpleRealTime.swift
//  Timer
//
//  Created by lkh on 12/4/23.
//

import SwiftUI

// MARK: - SimpleRealTime
struct SimpleRealTime: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    
    var body: some View {
        // MARK: 현재 타이머
        VStack(alignment: .center, spacing: 0) {
            Text(viewModel.currentPhaseText)
                .font(.system(size: 30, weight: .semibold))
            
            VStack {
                // 현재 라운드의 진행 중인 타이머 시간 표시
                RealTime(time: viewModel.currentTimerDisplayTime, fontSize: viewModel.selectedMovementAmount.timerBigFontSize)
            } // VStack
            .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundColor(.black)
    } // body
}

struct SimpleRealTime_Previews: PreviewProvider {
    static var previews: some View {
        SimpleRealTime()
        .environmentObject(SimpleViewModel.shared)    }
}
