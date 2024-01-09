//
//  DetailRealTime.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/01/04.
//

import SwiftUI

// MARK: - DetailRealTime
struct DetailRealTime: View {
    // MARK: 프로퍼티
    var currentTitle: String
    var currentDisplayTime: String
    let bigFontSize: CGFloat
    
    // MARK: - View
    var body: some View {
        // MARK: 현재 타이머
        VStack(alignment: .center, spacing: 0) {
            Text(currentTitle)
                .font(.system(size: 30, weight: .semibold))
            
            VStack {
                // 현재 라운드의 진행 중인 타이머 시간 표시
                RealTime(time: currentDisplayTime, fontSize: bigFontSize)
            } // VStack
            .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundColor(.black)
    } // body
}
