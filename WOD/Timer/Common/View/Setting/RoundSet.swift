//
//  RoundSet.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

// MARK: - RoundSet
struct RoundSet: View {
    // MARK: Binding
    @Binding var selectedRoundAmount: Int
    @Binding var isChange: Bool
    @Binding var showPopup: Bool
    
    // MARK: 프로퍼티
    let manager: InputManager
    
    // MARK: View
    var body: some View {
        // MARK: main
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                // MARK: - 초기화 & 전환
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {selectedRoundAmount = 3},
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
                    SettingTextField(setBinding: $selectedRoundAmount, title: "Round", viewModel: manager)
                }
                else {
                    SettingPicker(title: "round",
                                  range: manager.roundRange,
                                  binding: $selectedRoundAmount)
                    .onTapGesture {
                        isChange.toggle()
                    }
                }
            } // VStack
        } // GeometryReader
    } // body
}
