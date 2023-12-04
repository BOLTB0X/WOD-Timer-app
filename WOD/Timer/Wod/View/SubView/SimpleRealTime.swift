//
//  SimpleRealTime.swift
//  Timer
//
//  Created by lkh on 12/4/23.
//

import SwiftUI

struct SimpleRealTime: View {
    @EnvironmentObject private var viewModel: WodViewModel
    
    var body: some View {
        // MARK: 현재 타이머
        VStack(alignment: .center, spacing: 0) {
            Text(viewModel.currentPhaseText)
                .font(.system(size: 30, weight: .semibold))
            
            // 현재 라운드의 진행 중인 타이머 시간 표시
            RealTime(time: viewModel.currentDisplayTime, fontSize: viewModel.selectedMovementAmount.timerBigFontSize)
        }
    }
}

#Preview {
    SimpleRealTime()
        .environmentObject(WodViewModel.shared)
}