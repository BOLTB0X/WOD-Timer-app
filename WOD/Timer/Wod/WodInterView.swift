//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            VStack(alignment: .center, spacing: 0) {
                TimeSettingView()
                
            }
            .navigationTitle("WOD / Interval")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

#Preview {
    WodInterView()
}
