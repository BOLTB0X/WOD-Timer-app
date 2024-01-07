//
//  CustomTextField.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - TextFieldBackground
struct TextFieldBackground<Content: View>: View {
    private var content: Content
    
    // init
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.clear
            //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

// MARK: - CustomTextField
struct CustomTextField: View {
    // MARK: Binding
    @Binding var text: String
    
    // MARK: FocusState
    @FocusState private var focusedField: Bool
    
    // MARK: 프로퍼티
    let defaultText: String
    
    // MARK: - View
    var body: some View {
        TextFieldBackground {
            TextField(defaultText, text: $text)
                .focused($focusedField)
                .textFieldStyle(titleTextfieldStyle(input: $text))
                .padding(.horizontal)
                .onChange(of: text) { newValue in
                    if newValue.count > 20 {
                        text = String(newValue.prefix(20))
                    }
                } // onChange
        } // TextFieldBackground
        .onTapGesture {
            focusedField = false
        }
    } // body
}
