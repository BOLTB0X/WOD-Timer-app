//
//  SimpleRoundStopSet.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - SimpleRoundStopSet
struct SimpleRoundStopSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: SimpleViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State / Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            RoundSet(selectedRoundAmount: $manager.selectedRoundStop, isChange: $isChange,
                     showPopup: $showPopup, manager: manager)
        }
        // MARK: side
        .onAppear {
            manager.selectedRoundStop = viewModel.selectedRoundStop
        }
        .navigationTitle("Round")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedRoundStop = manager.selectedRoundStop
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
