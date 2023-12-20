//
//  SimpleNextRealTime.swift
//  Timer
//
//  Created by lkh on 12/4/23.
//

import SwiftUI

// MAKR: - SimpleNextRealTime
struct SimpleNextRealTime: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    
    var body: some View {
        // MARK: 다음 타이머
        VStack(alignment: .center, spacing: 0) {
            Text(viewModel.nextTimerPhase)
                .font(.system(size: 20, weight: .regular))            
            // 현재 다음 라운드나 페이즈 타이머 시간 표시
            RealTime(time: viewModel.nextTimerTime, fontSize: viewModel.selectedMovementAmount.timerSmallFontSize)
        }
        .foregroundColor(viewModel.isEnd)
    }
}

