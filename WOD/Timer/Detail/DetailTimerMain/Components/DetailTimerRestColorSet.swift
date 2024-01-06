//
//  DetailTimerRestColorSet.swift
//  Timer
//
//  Created by lkh on 1/3/24.
//

import SwiftUI

// MARK: - DetailTimerRestColorSet
struct DetailTimerRestColorSet: View {
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
            manager.isSelectedColor = viewModel.timerRestColor
        }
        .navigationTitle("Color")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { },
            completeAction: {
                viewModel.timerRestColor = manager.isSelectedColor
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
