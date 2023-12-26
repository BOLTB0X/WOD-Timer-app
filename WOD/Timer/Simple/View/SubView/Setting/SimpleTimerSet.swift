//
//  SimpleTimerSet.swift
//  Timer
//
//  Created by lkh on 12/20/23.
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
    
    var body: some View {
        // MARK: view
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

// MARK: - SimpleTimerPreparationSet
struct SimpleTimerPreparationSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: SimpleViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State/Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    var body: some View {
        // MARK: view
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
    }
}

// MARK: - SimpleTimerMovementsSet
struct SimpleTimerMovementsSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: SimpleViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State/Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    var body: some View {
        // MARK: view
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

// MARK: - SimpleTimerRestSet
struct SimpleTimerRestSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: SimpleViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State/Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    var body: some View {
        // MARK: view
        NavigationView {
            RestSet(selectedRestAmount: $manager.selectedRestAmount, isChange: $isChange,
                    showPopup: $showPopup, isCalculatedBtn: $manager.isCalculatedBtn, manager: manager)
        }
        // MARK: side
        .onAppear {
            manager.selectedRestAmount = viewModel.selectedRestAmount
        }
        .navigationTitle("Rest")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedRestAmount = manager.selectedRestAmount
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    }
}
