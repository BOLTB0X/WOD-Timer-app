//
//  RoundSet.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

struct RoundSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @State private var selectedAmount = 3
    @State private var isChange: Bool = false
    
    @Binding var showPopup: Bool
    let roundRange = Array(1...99)
    
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
                        SettingPicker(title: "round",
                                      range: roundRange,
                                      binding: $selectedAmount)
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
        .navigationTitle("Round")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: { 
                viewModel.selectedRoundAmount = selectedAmount
                showPopup.toggle()
            }
        )
    }
}
