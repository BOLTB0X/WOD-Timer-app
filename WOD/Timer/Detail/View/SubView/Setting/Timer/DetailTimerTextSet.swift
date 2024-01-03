//
//  DetailTimerTextSet.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - DetailTimerSetItemText
struct DetailTimerTextSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: Binding
    @Binding var showPopup: Bool
    
    // MARK: 프로퍼티
    @Binding var selectType: SelectedSetting?

    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            if selectType == .defaultMoveText {
                TextSet(inputText: $manager.movementText, showPopup: $showPopup, defaultText: viewModel.defaultMove.title)
            } else if selectType == .defaultRestText {
                TextSet(inputText: $manager.movementText, showPopup: $showPopup, defaultText: viewModel.defaultRest.title)
            } else {
                TextSet(inputText: $manager.movementText, showPopup: $showPopup, defaultText: viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].title)
            }
        }
        // MARK: side
        .onAppear {
            if selectType == .defaultMoveText {
                manager.movementText = viewModel.defaultMove.title
            } else if selectType == .defaultRestText {
                manager.movementText = viewModel.defaultRest.title
            } else {
                manager.movementText = viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].title
            }
        }
        .navigationTitle("Movement name")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { },
            completeAction: {
                if selectType == .defaultMoveText {
                    if !manager.movementText.isEmpty {
                        viewModel.defaultMove.title = manager.movementText
                    }
                } else if selectType == .defaultRestText {
                    if !manager.movementText.isEmpty {
                        viewModel.defaultRest.title = manager.movementText
                    }
                } else {
                    if !manager.movementText.isEmpty {
                        viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].title = manager.movementText
                    }
                }
                
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
