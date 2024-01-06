//
//  DetailNextRealTime.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/01/04.
//

import SwiftUI

// MARK: - DetailNextRealTime
struct DetailNextRealTime: View {
    // MARK: - Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: - View
    var body: some View {
        // MARK: main
        // MARK: 다음 타이머
        VStack(alignment: .center, spacing: 0) {
            Text(viewModel.nextTimerPhase)
                .font(.system(size: 20, weight: .regular))
            VStack {
                // 현재 다음 라운드나 페이즈 타이머 시간 표시
                RealTime(time: viewModel.nextTimerTime, fontSize: viewModel.selectedMovementAmount.timerSmallFontSize)
            } // VStack
            .fixedSize(horizontal: false, vertical: true)
        } // VStack
        .foregroundColor(viewModel.isTmEnd)
    } // body
}

