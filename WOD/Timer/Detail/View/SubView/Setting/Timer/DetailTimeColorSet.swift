//
//  DetailTimeColorSet.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - DetailTimerSetItemColor
struct DetailTimeColorSet: View {
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
            ColorSet(selectedColor: $manager.isSelectedColor, showPopup: $showPopup)
        }
        // MARK: side
        .onAppear {
            if selectType == .color {
                manager.isSelectedColor = viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].color
            } else if selectType == .defaultMoveColor {
                manager.isSelectedColor = viewModel.defaultMove.color
            } else if selectType == .defaultRestColor {
                manager.isSelectedColor = viewModel.defaultRest.color
            }
        }
        .navigationTitle("Color")
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { },
            completeAction: {
                if selectType == .color {
                    viewModel.timerLoopList[viewModel.selectedTimerLoopIndex].color = manager.isSelectedColor
                }  else if selectType == .defaultMoveColor {
                    viewModel.defaultMove.color = manager.isSelectedColor
                } else if selectType == .defaultRestColor {
                    viewModel.defaultRest.color = manager.isSelectedColor
                }
                showPopup.toggle()
            }
        ) // popupSettingToolbar
    } // body
}
