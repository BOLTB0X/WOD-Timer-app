//
//  PreparationSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

// MARK: - PreparationSet
struct PreparationSet: View {
    @Binding var selectedPreparationAmount: Int
    @Binding var isChange: Bool
    @Binding var showPopup: Bool
    
    let manager: InputManager
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                // MARK: - 초기화 & 전환
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {selectedPreparationAmount = 3},
                           label: {
                        Image(systemName: "gobackward")
                    })
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(!isChange ? "keyboard": "wheel") {
                        isChange.toggle()
                    }
                    .padding(.horizontal)
                } // HStack
                .foregroundColor(.secondary)
                
                // MARK: - set
                if isChange  {
                    SettingTextField(setBinding: $selectedPreparationAmount, title: "Preparation",viewModel: manager)
                }
                else {
                    SettingPicker(title: "Preparation",
                                  range: manager.preparationRange,
                                  binding: $selectedPreparationAmount)
                    .onTapGesture {
                        isChange.toggle()
                    }
                }
            } // VStack
        } // GeometryReader
    } // body
}

