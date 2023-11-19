//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

struct SimpleTimerView: View {
    @ObservedObject var timer = SimpleTimerManager.shared
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Text("\(timer.totalTime)")
            }
        }
    }
}

#Preview {
    SimpleTimerView()
}
