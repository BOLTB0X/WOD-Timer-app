//
//  MovementsSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

// MARK: - MovementsSet
struct MovementsSet: View {
    @Binding var selectedMovementAmount: MovementTime
    @Binding var isChange: Bool
    @Binding var showPopup: Bool
    @Binding var isCalculatedBtn: Bool
    
    let manager: InputManager
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                // MARK: - 초기화 & 전환
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {selectedMovementAmount = MovementTime(hours: 0, minutes: 0, seconds: 30)},
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
                    SettingTimeTextField(setHour: $selectedMovementAmount.hours, setMinute: $selectedMovementAmount.minutes, setSecond: $selectedMovementAmount.seconds, isUsedAuto: $isCalculatedBtn, viewModel: manager)
                }
                else {
                    HStack {
                        SettingPicker(title: "hour", range: manager.hoursRange, binding: $selectedMovementAmount.hours)
                        
                        Spacer()
                        
                        SettingPicker(title: "min", range: manager.minutesRange, binding: $selectedMovementAmount.minutes)
                        
                        Spacer()
                        
                        SettingPicker(title: "sec", range: manager.secondsRange, binding: $selectedMovementAmount.seconds)
                    } // HStack
                    .onTapGesture {
                        isChange.toggle()
                    }
                }
            } // VStack
        } // GeometryReader
    } // body
}
