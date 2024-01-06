//
//  SimpleTimerSet.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleTimerRestSet
struct SimpleTimerRestSet: View {
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
