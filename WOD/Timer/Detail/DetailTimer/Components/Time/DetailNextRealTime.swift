//
//  DetailNextRealTime.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/01/04.
//

import SwiftUI

// MARK: - DetailNextRealTime
struct DetailNextRealTime: View {
    // MARK: - 프로퍼티
    var nextPhase: String
    var nextTime: String
    var smallFontSize: CGFloat
    var backColor: Color
    
    // MARK: - View
    var body: some View {
        // MARK: main
        // MARK: 다음 타이머
        VStack(alignment: .center, spacing: 0) {
            Text(nextPhase)
                .font(.system(size: 20, weight: .regular))
            VStack {
                // 현재 다음 라운드나 페이즈 타이머 시간 표시
                RealTime(time: nextTime, fontSize: smallFontSize)
            } // VStack
            .fixedSize(horizontal: false, vertical: true)
        } // VStack
        .foregroundColor(backColor)

    } // body
}

