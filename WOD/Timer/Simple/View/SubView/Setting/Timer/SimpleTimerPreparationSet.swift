//
//  SimpleTimerPreparationSet.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - SimpleTimerPreparationSet
struct SimpleTimerPreparationSet: View {
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
            PreparationSet(selectedPreparationAmount: $manager.selectedPreparationAmount,
                           isChange: $isChange, showPopup: $showPopup, manager: manager)
        }
        // MARK: side
        .onAppear {
            manager.selectedPreparationAmount = viewModel.selectedPreparationAmount
        }
        .navigationTitle("Preparation")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedPreparationAmount = manager.selectedPreparationAmount
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
