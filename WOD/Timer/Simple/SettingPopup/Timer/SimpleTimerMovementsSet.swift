//
//  SimpleTimerMovementsSet.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - SimpleTimerMovementsSet
struct SimpleTimerMovementsSet: View {
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
            MovementsSet(selectedMovementAmount: $manager.selectedMovementAmount, isChange: $isChange,
                         showPopup: $showPopup, isCalculatedBtn: $manager.isCalculatedBtn, manager: manager)
        }
        // MARK: side
        .onAppear {
            manager.selectedMovementAmount = viewModel.selectedMovementAmount
        }
        .navigationTitle("Movements")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedMovementAmount = manager.selectedMovementAmount
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    }
}
