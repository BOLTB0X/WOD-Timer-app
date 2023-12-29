//
//  DetailTimerSetItem.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - DetailTimerSetItem
// ...
// MARK: - DetailTimerSetItemColor
struct DetailTimerSetItemColor: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: Binding
    @Binding var showPopup: Bool
        
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            ColorSet(selectedColor: $manager.isSelectedColor, showPopup: $showPopup)
        }
        // MARK: side
        .onAppear {
            manager.isSelectedColor = viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].color
        }
        .navigationTitle("Color")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { },
            completeAction: {
                viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].color = manager.isSelectedColor
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}

// MARK: - DetailTimerSetItemText
struct DetailTimerSetItemText: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: Binding
    @Binding var showPopup: Bool
        
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            TextSet(inputText: $manager.movementText, showPopup: $showPopup, defaultText: viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].title)
        }
        // MARK: side
        .onAppear {
            manager.movementText = viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].title
        }
        .navigationTitle("Movement name")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { },
            completeAction: {
                if !manager.movementText.isEmpty {
                    viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].title = manager.movementText
                }
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}

// MARK: - SimpleTimerMovementsSet
struct DetailTimerSetItemMovement: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State / Binding
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
            manager.selectedMovementAmount = viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].time
        }
        .navigationTitle("Movements")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.timerCycleList[viewModel.selectedTimerCycleIndex].time = manager.selectedMovementAmount
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
