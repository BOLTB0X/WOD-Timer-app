//
//  TimeSettingPicker.swift
//  Timer
//
//  Created by lkh on 11/4/23.
//

import SwiftUI

struct TimeSettingPicker: View {
    let title: String
    let range: [Int]
    @Binding var binding: Int
    
    var body: some View {
        Picker(title, selection: $binding) {
            ForEach(range, id: \.self) { timeIncrement in
                
                Text("\(timeIncrement)")
                    .font(.system(size: 40))
                    //.foregroundColor(.white)
                    .padding()
                
            }
        }
        .labelsHidden()
        .pickerStyle(InlinePickerStyle())
    }
}
