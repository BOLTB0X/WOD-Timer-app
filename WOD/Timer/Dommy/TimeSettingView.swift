//
//  PickerView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

//struct TimeSettingView: View {
//    @ObservedObject private var model = WodInterViewModel()
//    @State private var isChange: Bool = false
//    
//    var body: some View {
//        VStack(alignment: .center, spacing: 0) {
//            if isChange  {
//                SettingTimeTextField(setHour: $model.selectedHoursAmount,
//                                     setMinute: $model.selectedMinutesAmount,
//                                     setSecond: $model.selectedSecondsAmount,
//                                     isChange: $isChange, isUsedAuto: $model.isCalculatedBtn, viewModel: model)
//            }
//            else {
//                HStack {
//                    SettingPicker(title: "hour",
//                                      range: model.minutesRange,
//                                      binding: $model.selectedHoursAmount)
//                    
//                    Spacer()
//                    
//                    SettingPicker(title: "min",
//                                      range: model.minutesRange,
//                                      binding: $model.selectedMinutesAmount)
//                    
//                    Spacer()
//                    
//                    SettingPicker(title: "sec",
//                                      range: model.secondsRange,
//                                      binding: $model.selectedSecondsAmount)
//                }
//                .onTapGesture {
//                    isChange.toggle()
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    TimeSettingView()
//}
