//
//  MovementsSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct MovementsSet: View {
    @EnvironmentObject var viewModel: SimpleViewModel
    @StateObject var manager = InputManager()

    @State private var isChange: Bool = false
    @Binding var showPopup: Bool

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - 초기화 & 전환
                    HStack(alignment: .center, spacing: 0) {
                        Button(action: {manager.selectedMovementAmount = MovementTime(hours: 0, minutes: 0, seconds: 30)},
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
                        SettingTimeTextField(setHour: $manager.selectedMovementAmount.hours, setMinute: $manager.selectedMovementAmount.minutes, setSecond: $manager.selectedMovementAmount.seconds, isUsedAuto: $manager.isCalculatedBtn, viewModel: manager)
                    }
                    else {
                        HStack {
                            SettingPicker(title: "hour", range: manager.hoursRange, binding: $manager.selectedMovementAmount.hours)
                            
                            Spacer()
                            
                            SettingPicker(title: "min", range: manager.minutesRange, binding: $manager.selectedMovementAmount.minutes)
                            
                            Spacer()
                            
                            SettingPicker(title: "sec", range: manager.secondsRange, binding: $manager.selectedMovementAmount.seconds)
                        }
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
        .onAppear {
            manager.selectedMovementAmount = viewModel.selectedMovementAmount
        }
        .navigationTitle("Movements")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedMovementAmount = manager.selectedMovementAmount
                showPopup.toggle()
            }
        )
    }
}
