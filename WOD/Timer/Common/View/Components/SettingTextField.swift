//
//  SettingTextField.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

// MARK: - SettingTextField
struct SettingTextField: View {
    @Binding var setBinding: Int
    @FocusState private var focusedField: Bool
    @ObservedObject var input = TextManager(limit: 2)
    
    let title: String
    let viewModel: InputManager

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Spacer()
                    
                    TextField("\(title)", value: $setBinding, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField)
                        .onChange(of: setBinding) { newValue in
                            if String(newValue) == "0" {
                                setBinding = 1
                            } else {
                                setBinding = newValue % 100
                            }
                        } // onChange
                    
                    Spacer()
                } // HStack
            } // VStack
            .onTapGesture {
                focusedField = false
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("+") { setBinding += 1 }
                    
                    Spacer()
                    
                    Button("-") {
                        if setBinding > 0 {
                            setBinding -= 1
                        }
                    }
                }
            } // toolbar
        } // NavigationView
    } // body
}
