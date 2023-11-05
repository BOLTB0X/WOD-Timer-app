//
//  PickerView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct TimeSettingView: View {
    @ObservedObject private var model = WodInterViewModel()
    @State private var isChange: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if isChange  {
                TimeSettingTextField(setHour: $model.selectedHoursAmount,
                                     setMinute: $model.selectedMinutesAmount,
                                     setSecond: $model.selectedSecondsAmount,
                                     isChange: $isChange, isUsedAuto: $model.isCalculatedBtn, viewModel: model)
            }
            else {
                HStack {
                    TimeSettingPicker(title: "hour",
                                      range: model.minutesRange,
                                      binding: $model.selectedHoursAmount)
                    
                    Spacer()
                    
                    TimeSettingPicker(title: "min",
                                      range: model.minutesRange,
                                      binding: $model.selectedMinutesAmount)
                    
                    Spacer()
                    
                    TimeSettingPicker(title: "sec",
                                      range: model.secondsRange,
                                      binding: $model.selectedSecondsAmount)
                }
                .onTapGesture {
                    isChange.toggle()
                }
            }
        }
    }
}

#Preview {
    TimeSettingView()
}
