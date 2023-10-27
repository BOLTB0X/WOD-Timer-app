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
                List {
                    Section(header: Text("Right now")) {

                    }
                }
            }
            .navigationTitle("WOD / Interval")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    WodInterView()
}
