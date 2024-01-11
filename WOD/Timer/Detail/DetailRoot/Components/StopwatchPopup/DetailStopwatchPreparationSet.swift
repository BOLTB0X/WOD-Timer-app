//
//  DetailStopwatchPreparationSet.swift
//  Timer
//
//  Created by lkh on 1/7/24.
//

import SwiftUI

// MARK: - DetailStopwatchPreparationSet
struct DetailStopwatchPreparationSet: View {
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

