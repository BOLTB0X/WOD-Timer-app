//
//  RestSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct RestSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @StateObject var manager = InputManager()
    @Binding var showPopup: Bool

    @State private var isChange: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - 초기화 & 전환
                    HStack(alignment: .center, spacing: 0) {
                        Button(action: {
                            manager.selectedRestAmount = MovementTime(hours: 0, minutes: 0, seconds: 10)
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
                    }
                    .foregroundColor(.secondary)
                    
                    // MARK: - set
                    if isChange  {
                        SettingTwoTextField(setMinute: $manager.selectedRestAmount.minutes, setSecond: $manager.selectedRestAmount.seconds,isUsedAuto: $manager.isCalculatedBtn,  viewModel: manager)
                    }
                    else {
                        HStack {
                            SettingPicker(title: "min", range: manager.minutesRange, binding: $manager.selectedRestAmount.minutes)
                            
                            Spacer()
                            
                            SettingPicker(title: "sec", range: manager.minutesRange, binding: $manager.selectedRestAmount.seconds)
                        }
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
        .onAppear {
            manager.selectedRestAmount = viewModel.selectedRestAmount
        }
        .navigationTitle("Rest")
        .navigationBarTitleDisplayMode(.inline)
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  { isChange.toggle() },
            completeAction: {
                viewModel.selectedRestAmount = manager.selectedRestAmount
                showPopup.toggle()
            }
        )
    }
}
