//
//  PreparationSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct PreparationSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @StateObject var manager = InputManager()
    @State private var isChange: Bool = false
    
    @Binding var showPopup: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - 초기화 & 전환
                    HStack(alignment: .center, spacing: 0) {
                        Button(action: {manager.selectedPreparationAmount = 3},
                               label: {
                            Image(systemName: "gobackward")
                        })
                        .padding(.horizontal)
                        
                        Spacer()

                        Button(!isChange ? "keyboard": "wheel") {
                            isChange.toggle()
                        }
                        .padding(.horizontal)
                    }
                    .foregroundColor(.secondary)
                    
                    // MARK: - set
                    if isChange  {
                        SettingTextField(setBinding: $manager.selectedPreparationAmount, title: "Preparation",viewModel: manager)
                    }
                    else {
                        SettingPicker(title: "Preparation",
                                      range: manager.preparationRange,
                                      binding: $manager.selectedPreparationAmount)
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
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
        )
        
    }
}

