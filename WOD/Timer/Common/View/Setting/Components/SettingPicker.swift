//
//  TimeSettingPicker.swift
//  Timer
//
//  Created by lkh on 11/4/23.
//

import SwiftUI

struct SettingPicker: View {
    let title: String
    let range: [Int]
    @Binding var binding: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Picker(title, selection: $binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    
                    Text("\(timeIncrement)")
                        .font(.system(size: 35))
                        .padding()
                    
                } // ForEach
            } // Picker
            .labelsHidden()
            .pickerStyle(InlinePickerStyle())
            Spacer()
        } // VStack
    } // body
}
