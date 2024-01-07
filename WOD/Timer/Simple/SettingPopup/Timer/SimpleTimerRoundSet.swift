//
//  SimpleTimerRoundSet.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - SimpleTimerRoundSet
struct SimpleTimerRoundSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: SimpleViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State/Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            RoundSet(selectedRoundAmount: $manager.selectedRoundAmount,
                     isChange: $isChange, showPopup: $showPopup,  manager: manager)
        }
        // MARK: side
        .onAppear {
            manager.selectedRoundAmount = viewModel.selectedRoundAmount
        }
        .navigationTitle("Round")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedRoundAmount = manager.selectedRoundAmount
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
