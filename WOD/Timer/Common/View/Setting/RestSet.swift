//
//  RestSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

// MARK: - RestSet
struct RestSet: View {
    // MARK: Binding
    @Binding var selectedRestAmount: MovementTime
    @Binding var isChange: Bool
    @Binding var showPopup: Bool
    @Binding var isCalculatedBtn: Bool
    
    // MARK: 프로퍼티
    let manager: InputManager
    
    // MARK: - View
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                // MARK: - 초기화 & 전환
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {
                        selectedRestAmount = MovementTime(hours: 0, minutes: 0, seconds: 10)
                    },
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
                    SettingTwoTextField(setMinute: $selectedRestAmount.minutes, setSecond: $selectedRestAmount.seconds, isUsedAuto: $isCalculatedBtn,  viewModel: manager)
                }
                else {
                    HStack {
                        SettingPicker(title: "min", range: manager.minutesRange, binding: $selectedRestAmount.minutes)
                        
                        Spacer()
                        
                        SettingPicker(title: "sec", range: manager.secondsRange, binding: $selectedRestAmount.seconds)
                    } // HStack
                    .onTapGesture {
                        isChange.toggle()
                    }
                }
            } // VStack
        } // GeometryReader
    } // body
}
