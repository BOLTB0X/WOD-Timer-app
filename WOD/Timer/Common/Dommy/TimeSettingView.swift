//
//  PickerView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct TimeSettingView: View {
    @ObservedObject private var model = TimeSettingInput()
    @State private var isChange: Bool = false

    var body: some View {
        if isChange  {
            TimeSettingTextField(setHour: $model.selectedHoursText,
                                 setminute: $model.selectedMinutesText,
                                 setSecond: $model.selectedSecondsText,
                                isChange: $isChange)
        }
        else {
            HStack {
                TimeSettingPicker(title: "hour",
                                  range: model.minutesRange,
                                  binding: $model.selectedHoursPicker)
                
                Spacer()
                
                TimeSettingPicker(title: "min",
                                  range: model.minutesRange,
                                  binding: $model.selectedMinutesPicker)
                
                Spacer()
                
                TimeSettingPicker(title: "sec",
                                  range: model.secondsRange,
                                  binding: $model.selectedSecondsPicker)
            }
            .padding(.all, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .foregroundColor(.white)
            .onTapGesture {
                isChange.toggle()
            }
        }
    }
}

#Preview {
    TimeSettingView()
}
