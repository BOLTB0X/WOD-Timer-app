//
//  SimpleStopwatchSet.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleStopwatchSet
// ...
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

// MARK: - SimpleStopwatchPreparationSet
struct SimpleStopwatchPreparationSet: View {
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
            PreparationSet(selectedPreparationAmount: $manager.selectedPreparationStop,
                           isChange: $isChange, showPopup: $showPopup, manager: manager)
        }
        // MARK: side
        .onAppear {
            manager.selectedPreparationStop = viewModel.selectedPreparationStop
        }
        .navigationTitle("Preparation")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedPreparationStop = manager.selectedPreparationStop
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
