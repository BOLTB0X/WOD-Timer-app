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
    @Binding var setminute: Int
    @Binding var setSecond: Int
    @FocusState private var focusedField: Field?
    
    @Binding var isChange: Bool
    
    var body: some View {
        HStack {
            TextField("hh", value: $setHour, format: .number)
                .textFieldStyle(CommonTextfieldStyle())
                .focused($focusedField, equals: .hh)

            Spacer()
            
            TextField("mm", value: $setHour, format: .number)
                .textFieldStyle(CommonTextfieldStyle())
                .focused($focusedField, equals: .mm)
            
            Spacer()
            
            TextField("ss", value: $setHour, format: .number)
                .textFieldStyle(CommonTextfieldStyle())
                .focused($focusedField, equals: .ss)

        }
        .background(.black)
    }
}

struct CommonTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .foregroundColor(Color.gray)
            
            // 텍스트필드
            configuration
                .keyboardType(.numberPad)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

