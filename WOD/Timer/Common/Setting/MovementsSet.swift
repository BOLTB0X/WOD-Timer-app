//
//  MovementsSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct MovementsSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @Binding var isChange: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    if isChange  {
                        SettingTimeTextField(setHour: $viewModel.selectedMovementAmount.hours, setMinute: $viewModel.selectedMovementAmount.minutes, setSecond: $viewModel.selectedMovementAmount.seconds, isUsedAuto: $viewModel.isCalculatedBtn, viewModel: viewModel)
                    }
                    else {
                        HStack {
                            SettingPicker(title: "hour", range: viewModel.hoursRange, binding: $viewModel.selectedMovementAmount.hours)
                            
                            Spacer()
                            
                            SettingPicker(title: "min", range: viewModel.minutesRange, binding: $viewModel.selectedMovementAmount.minutes)
                            
                            Spacer()
                            
                            SettingPicker(title: "sec", range: viewModel.minutesRange, binding: $viewModel.selectedMovementAmount.seconds)
                        }
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
            
        }
    }
}
