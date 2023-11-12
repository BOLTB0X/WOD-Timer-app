//
//  TimeSettingTextFieldView.swift
//  Timer
//
//  Created by lkh on 11/4/23.
//

import SwiftUI

enum Field {
    case hh
    case mm
    case ss
}

// MARK: - SettingTimeTextField
struct SettingTimeTextField: View {
    @Binding var setHour: Int
    @Binding var setMinute: Int
    @Binding var setSecond: Int
    @Binding var isUsedAuto: Bool
    
    @FocusState private var focusedField: Field?
    
    let viewModel: WodViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 10) {
                    TextField("hh", value: $setHour, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .hh)
                        .onChange(of: setHour) { newValue in
                            viewModel.updateValuesForField(.hh, newValue: newValue)
                        }
                    
                    TextField("mm", value: $setMinute, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .mm)
                        .onChange(of: setMinute) { newValue in
                            viewModel.updateValuesForField(.mm, newValue: newValue)
                        }
                    
                    TextField("ss", value: $setSecond, format: .number)
                        .textFieldStyle(CommonTextfieldStyle())
                        .focused($focusedField, equals: .ss)
                        .onChange(of: setSecond) { newValue in
                            viewModel.updateValuesForField(.ss, newValue: newValue)
                        }
                }
                .padding()
            }
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
    
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

struct CommonTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .foregroundColor(Color.gray.opacity(0.1))
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                .frame(height: 80)
            
            // 텍스트필드
            configuration
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(.numberPad)
                .font(.system(size: 50))
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

