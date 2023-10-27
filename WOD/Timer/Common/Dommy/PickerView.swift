//
//  PickerView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct TimePickerView: View {
    private let pickerViewTitlePadding: CGFloat = 4.0

    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>

    var body: some View {
        HStack(alignment: .center) {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        // Forces the text in the Picker to be
                        // right-aligned
                        Spacer()
                        Text("\(timeIncrement)")
                            //.foregroundColor(.white)
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

struct PickerView: View {
    @StateObject private var model = MovementsViewModel()

    var body: some View {
        HStack {
            TimePickerView(title: "min",
                range: model.minutesRange,
                binding: $model.selectedMinutesAmount)
            Spacer()
            TimePickerView(title: "sec",
                range: model.secondsRange,
                binding: $model.selectedSecondsAmount)
        }
        .padding(.all, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(.black)
        //.foregroundColor(.white)
    }
}

#Preview {
    PickerView()
}
