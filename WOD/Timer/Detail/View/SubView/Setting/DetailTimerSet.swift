//
//  DetailTimerSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailTimerSet
// ...
// MARK: - DeatilTimerPreparationSet
struct DeatilTimerPreparationSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
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
    } // body
}

// MARK: - DetailTimerRoundSet
struct DetailTimerRoundSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
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

// MARK: - SimpleTimerRestSet
struct DetailTimerRestSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State/Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    // MARK: - View
    var body: some View {
        // MARK: main
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
    } // body
}
