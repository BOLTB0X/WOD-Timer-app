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
    @Binding var text: String
    @FocusState private var focusedField: Bool
    
    let defaultText: String
    
    var body: some View {
        TextFieldBackground {
            TextField(defaultText, text: $text)
                .focused($focusedField)
                .textFieldStyle(titleTextfieldStyle(input: $text))
                .padding(.horizontal)
        } // TextFieldBackground
        .onTapGesture {
            focusedField = false
        }
    } // body
}
