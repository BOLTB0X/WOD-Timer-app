//
//  SettingTextField.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI


struct SettingTextField: View {
    @Binding var setBinding: Int

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
                            setBinding = newValue % 100
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
                    
                    Button("-") { setBinding -= 1 }
                }
            }
        }
    }
}
