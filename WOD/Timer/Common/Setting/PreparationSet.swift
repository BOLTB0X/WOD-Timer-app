//
//  PreparationSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct PreparationSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @State private var selectedAmount = 3
    @State private var isChange: Bool = false
    
    @Binding var showPopup: Bool
    let preparationRange = Array(0...60)
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - 초기화 & 전환
                    HStack(alignment: .center, spacing: 0) {
                        Button(action: {selectedAmount = 3},
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
                        SettingTextField(setBinding: $selectedAmount, complete: $showPopup)
                    }
                    else {
                        SettingPicker(title: "Preparation",
                                      range: preparationRange,
                                      binding: $selectedAmount)
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
        .navigationTitle("Preparation")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: { 
                viewModel.selectedPreparationAmount = selectedAmount
                showPopup.toggle()
            }
        )
        
    }
}

