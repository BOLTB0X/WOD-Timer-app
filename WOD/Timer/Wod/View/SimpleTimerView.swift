//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

struct SimpleTimerView: View {
    @EnvironmentObject private var viewModel: WodViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Text(",)")
            }
        }
    }
}

#Preview {
    SimpleTimerView()
        .environmentObject(WodViewModel())
}
