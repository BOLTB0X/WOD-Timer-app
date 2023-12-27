//
//  ColorButton.swift
//  Timer
//
//  Created by lkh on 12/26/23.
//

import SwiftUI

// MARK: - ColorSegmentedButton
struct ColorSegment: View {
    // MARK: Biding
    @Binding var selectedIndex: Int
    
    // MARK: 프로퍼티
    private let colorOptions: [String] = ["lightBlue2", "lightBlue3", "lightBlue4", "lightBlue1", "lightGreen1", "lightGreen2", "lightGreen3", "lightGreen4", "lightYellow1", "lightYellow3", "lightYellow2", "lightYellow4", "lightRed1", "lightRed2", "lightRed3", "lightRed4", "lightWhite"]
    
    // MARK: View
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(colorOptions.indices, id:\.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(Color(colorOptions[index]))
                            .frame(width: 80, height: 80)
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
        ColorSegment(selectedIndex: .constant(0))
    }
}
