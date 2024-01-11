//
//  DeatilStopwatchPreparationColorSet.swift
//  Timer
//
//  Created by lkh on 1/7/24.
//

import SwiftUI

// MARK: - DeatilStopwatchPreparationColorSet
struct DeatilStopwatchPreparationColorSet: View {
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
            manager.isSelectedColor = viewModel.stopPreparationColor
        }
        .navigationTitle("Color")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { },
            completeAction: {
                viewModel.stopPreparationColor = manager.isSelectedColor
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}

