//
//  SettingTwoTextField.swift
//  Timer
//
//  Created by lkh on 11/20/23.
//

import SwiftUI

// MARK: - SettingTwoTextField
struct SettingTwoTextField: View {
    // MARK: Binding
    @Binding var setMinute: Int
    @Binding var setSecond: Int
    @Binding var isUsedAuto: Bool
    
    // MARK: FocusState
    @FocusState private var focusedField: Field?
    
    // MARK: 프로퍼티
    let viewModel: InputManager
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 10) {
                    TextField("mm", value: $setMinute, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .mm)
                        .onChange(of: setMinute) { newValue in
                            viewModel.updateRestValuesForField(.mm, newValue: newValue)
                        }
                    
                    TextField("ss", value: $setSecond, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .ss)
                        .onChange(of: setSecond) { newValue in
                            viewModel.updateRestValuesForField(.ss, newValue: newValue)
                        }
                } // HStack
                .padding()
            } // VStack
            // MARK: side
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("before") {
                        keyboardToolbar_BeforeBtn()
                    }
                    Spacer()
                    
                    Toggle("auto Calculator", isOn: $isUsedAuto)
                    Spacer()
                    
                    Button("next") {
                        keyboardToolbar_NextBtn()
                    }
                }
            } // toolbar
            .onTapGesture {
                focusedField = nil
            }
        } // NavigationView
    } // body
    
    // MARK: - method
    // ...
    // MARK: - keyboardToolbar_BeforeBtn
    private func keyboardToolbar_BeforeBtn() {
        switch focusedField {
        case .hh:
            break
        case .mm:
            focusedField = .ss
        case .ss:
            focusedField = .mm
        default:
            break
        }
    }
    
    // MARK: - keyboardToolbar_NextBtn
    private func keyboardToolbar_NextBtn() {
        switch focusedField {
        case .hh:
            break
        case .mm:
            focusedField = .ss
        case .ss:
            focusedField = .mm
        default:
            break
        }
    }
}

