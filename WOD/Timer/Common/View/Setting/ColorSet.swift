//
//  ColorSet.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - ColorSet
struct ColorSet: View {
    // MARK: Binding
    @Binding var selectedColor: Int
    @Binding var showPopup: Bool
    
    // MARK: View
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center, spacing: 0) {
                // MARK: - 초기화 & 전환
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {selectedColor = 0},
                           label: {
                        Image(systemName: "gobackward")
                    })
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    .padding(.horizontal)
                } // HStack
                .foregroundColor(.secondary)
                
                Spacer()
                // MARK: - set
                ColorSegment(selectedIndex: $selectedColor)
                
                Spacer()
            } // VStack
        } // GeometryReader
    } // body
}
