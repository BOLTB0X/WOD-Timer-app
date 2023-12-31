//
//  TimeSettingTextFieldView.swift
//  Timer
//
//  Created by lkh on 11/4/23.
//

import SwiftUI

// MARK: - SettingTimeTextField
struct SettingTimeTextField: View {
    // MARK: Binding
    @Binding var setHour: Int
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
                    TextField("hh", value: $setHour, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .hh)
                        .onChange(of: setHour) { newValue in
                            if String(newValue).count >= 2 &&  String(newValue).first! == "0" {
                                setHour = 0
                            }
                            viewModel.updateMovementValuesForField(.hh, newValue: newValue)
                        } // onChange
                    
                    TextField("mm", value: $setMinute, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .mm)
                        .onChange(of: setMinute) { newValue in
                            if String(newValue).count >= 2 &&  String(newValue).first! == "0" {
                                setMinute = 0
                            }
                            viewModel.updateMovementValuesForField(.mm, newValue: newValue)
                        } // onChange
                    
                    TextField("ss", value: $setSecond, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .ss)
                        .onChange(of: setSecond) { newValue in
                            if String(newValue).count >= 2 &&  String(newValue).first! == "0" {
                                setSecond = 0
                            }
                            viewModel.updateMovementValuesForField(.ss, newValue: newValue)
                        } // onChange
                } // HSyack
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
        }// NavigationView
    }// body
    
    // MARK: - method
    // ...
    // MARK: - keyboardToolbar_BeforeBtn
    private func keyboardToolbar_BeforeBtn() {
        switch focusedField {
        case .hh:
            focusedField = .ss
        case .mm:
            focusedField = .hh
        case .ss:
            focusedField = .mm
        default:
            break
        }
    }
    
    // MARK: - keyboardToolbar_BeforeBtn
    private func keyboardToolbar_NextBtn() {
        switch focusedField {
        case .hh:
            focusedField = .mm
        case .mm:
            focusedField = .ss
        case .ss:
            focusedField = .hh
        default:
            break
        }
    }
}
