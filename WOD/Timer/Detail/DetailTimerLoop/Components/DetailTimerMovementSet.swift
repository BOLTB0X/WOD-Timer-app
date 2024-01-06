//
//  DetailTimerSetItem.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - SimpleTimerMovementsSet
struct DetailTimerMovementSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State / Binding
    @State private var isChange: Bool = false
    @Binding var showPopup: Bool
    
    // MARK: 프로퍼티
    @Binding var selectType: SelectedSetting?
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            MovementsSet(
                selectedMovementAmount: $manager.selectedMovementAmount,
                isChange: $isChange,
                showPopup: $showPopup,
                isCalculatedBtn: $manager.isCalculatedBtn,
                manager: manager)
        }
        // MARK: side
        .onAppear {
            if selectType == .defaultMoveTime {
                manager.selectedMovementAmount = viewModel.defaultMove.time
            } else if selectType == .defaultRestTime {
                manager.selectedMovementAmount = viewModel.defaultRest.time
            } else {
                manager.selectedMovementAmount = viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].time
            }
        }
        .navigationTitle("Movements")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                if selectType == .defaultMoveTime {
                    viewModel.defaultMove.time = manager.selectedMovementAmount
                } else if selectType == .defaultRestTime {
                    viewModel.defaultRest.time = manager.selectedMovementAmount
                } else {
                    viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].time = manager.selectedMovementAmount
                }
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
