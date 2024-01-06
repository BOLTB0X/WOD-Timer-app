//
//  SettingTextField.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

// MARK: - SettingTextField
struct SettingTextField: View {
    // MARK: Object
    @ObservedObject var input = TextManager(limit: 2)
    
    // MARK: Binding
    @Binding var setBinding: Int
    
    // MARK: FocusState
    @FocusState private var focusedField: Bool
    
    // MARK: 프로퍼티s
    let title: String
    let viewModel: InputManager

    // MARK: - View
    var body: some View {
        // MARK: main
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
            
            // MARK: side
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
