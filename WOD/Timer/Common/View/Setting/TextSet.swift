//
//  TextSet.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - TextSet
struct TextSet: View {
    // MARK: Binding
    @Binding var inputText: String
    @Binding var showPopup: Bool
    
    // MARK: 프로퍼티s
    let defaultText: String
    
    // MARK: - View
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center, spacing: 0) {
                // MARK: - 초기화 & 전환
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {inputText = defaultText},
                           label: {
                        Image(systemName: "gobackward")
                    })
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    .padding(.horizontal)
                } // HStack
                .foregroundColor(.secondary)
                
                // MARK: - set
                CustomTextField(text: $inputText, defaultText: defaultText)
            } // VStack
        } // GeometryReader
    } // body
}

