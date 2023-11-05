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

// MARK: - TimeSettingTextField
struct TimeSettingTextField: View {
    @Binding var setHour: Int
    @Binding var setMinute: Int
    @Binding var setSecond: Int
    @FocusState private var focusedField: Field?
    @Binding var isChange: Bool
    @Binding var isUsedAuto: Bool
    
    let viewModel: WodInterViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Button("back") {
                isChange.toggle()
            }
            HStack(alignment: .center, spacing: 0) {
                TextField("hh", value: $setHour, format: .number)
                    .textFieldStyle(CommonTextfieldStyle())
                    .focused($focusedField, equals: .hh)
                    .onChange(of: setHour) { newValue in
                        viewModel.updateValuesForField(.hh, newValue: newValue)
                    }
                
                Spacer()
                
                Text(":")
                
                Spacer()
                
                TextField("mm", value: $setMinute, format: .number)
                    .textFieldStyle(CommonTextfieldStyle())
                    .focused($focusedField, equals: .mm)
                    .onChange(of: setMinute) { newValue in
                        viewModel.updateValuesForField(.mm, newValue: newValue)
                    }
                
                Spacer()
                
                Text(":")
                
                Spacer()
                
                TextField("ss", value: $setSecond, format: .number)
                    .textFieldStyle(CommonTextfieldStyle())
                    .focused($focusedField, equals: .ss)
                    .onChange(of: setSecond) { newValue in
                        viewModel.updateValuesForField(.ss, newValue: newValue)
                    }
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
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            hideKeyboard()
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
                .keyboardType(.numberPad)
                .font(.system(size: 60))
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
