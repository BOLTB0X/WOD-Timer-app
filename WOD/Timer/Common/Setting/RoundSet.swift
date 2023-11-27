//
//  RoundSet.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

struct RoundSet: View {
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
                        Button(action: {manager.selectedRoundAmount = 3},
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
                        SettingTextField(setBinding: $manager.selectedRoundAmount, title: "Round",viewModel: manager)
                    }
                    else {
                        SettingPicker(title: "round",
                                      range: manager.roundRange,
                                      binding: $manager.selectedRoundAmount)
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
        .onAppear {
            manager.selectedRoundAmount = viewModel.selectedRoundAmount
        }
        .navigationTitle("Round")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: { 
                viewModel.selectedRoundAmount = manager.selectedRoundAmount
                showPopup.toggle()
            }
        )
    }
}
