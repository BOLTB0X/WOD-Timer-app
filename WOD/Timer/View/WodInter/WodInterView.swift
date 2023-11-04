//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    var body: some View {
        NavigationView { // navigationTitle 이용 및 뷰 구성을 위해
            VStack {
                //SimpleSetupView()
            }
            .navigationTitle("WOD / Interval")
//            .navigationBarTitleDisplayMode(.inline)
//            .onTapGesture { // 키보드 내리기용
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//            }
        }
    }
}

#Preview {
    WodInterView()
}
