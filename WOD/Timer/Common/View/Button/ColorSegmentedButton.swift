//
//  ColorButton.swift
//  Timer
//
//  Created by lkh on 12/26/23.
//

import SwiftUI

// MARK: - ColorSegmentedButton
struct ColorSegmentedButton: View {
    @Binding var selectedIndex: Int
    
    let colorOptions: [String] = ["lightBlue2", "lightBlue3", "lightBlue4", "lightBlue1", "lightGreen1", "lightGreen2", "lightGreen3", "lightGreen4", "lightYellow1", "lightYellow3", "lightYellow2", "lightYellow4", "lightRed1", "lightRed2", "lightRed3", "lightRed4", "lightWhite"]
        
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(colorOptions.indices, id:\.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(Color(colorOptions[index]))
                            .frame(width: 50, height: 50)
                    } // ZStack
                    .overlay(
                        Button(action: {
                            selectedIndex = index
                        }, label: {
                            Image(systemName: "checkmark")
                                .foregroundColor(selectedIndex == index ? .black : Color(colorOptions[index]))
                        })
                    ) // overlay
                } // ForEach
            } // HStack
        } // ScrollView
        .onAppear {
                    UIScrollView.appearance().isPagingEnabled = true
                }
    } // body
}

struct ColorSegmentedButton_Previews: PreviewProvider {
    static var previews: some View {
        ColorSegmentedButton(selectedIndex: .constant(0))
    }
}
