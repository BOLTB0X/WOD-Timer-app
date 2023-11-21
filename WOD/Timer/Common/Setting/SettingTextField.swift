//
//  SettingTextField.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct SettingTextField: View {
    @Binding var setBinding: Int
    @Binding var complete: Bool

    @FocusState private var focusedField: Bool
    
    let viewModel: InputManager

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Spacer()
                    TextField("Round", value: $setBinding, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField)
                        .onChange(of: setBinding) { newValue in
                            if String(newValue).count >= 2 &&  String(newValue).first! == "0" {
                                setBinding = 0
                            } else {
                                setBinding = newValue >= 100 ? newValue % 100 : newValue
                            }
                        }
                    Spacer()
                }
            }
            .onTapGesture {
                focusedField = false
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("+") { setBinding += 1 }
                    
                    Spacer()
                    
                    Button("complete") { complete.toggle() }
                    
                    Spacer()
                    
                    Button("-") { setBinding -= 1 }
                }
            }
        }
    }
}
