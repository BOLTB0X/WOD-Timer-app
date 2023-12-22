//
//  DetailTimerCycleSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailTimerCycleSet
struct DetailTimerCycleSet: View {
    @EnvironmentObject private var viewModel: DetailViewModel

    var body: some View {
        NavigationView {
            Text("d")
        } // NavigationView
    }
}

struct DetailTimerCycleSet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerCycleSet()
            .environmentObject(DetailViewModel.shared)
    }
}
