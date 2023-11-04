//
//  TimeSettingPicker.swift
//  Timer
//
//  Created by lkh on 11/4/23.
//

import SwiftUI

struct TimeSettingPicker: View {
    //private let pickerViewTitlePadding: CGFloat = 4.0

    let title: String
    let range: [Int]
    @Binding var binding: Int

    var body: some View {
        HStack(alignment: .center) {
            Picker(title, selection: $binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        Spacer()
                        Text("\(timeIncrement)")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(InlinePickerStyle())
            .labelsHidden()

            Text(title)
                .fontWeight(.bold)
        }
    }
}
