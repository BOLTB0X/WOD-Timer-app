//
//  TextfieldStyle.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

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

extension NumberFormatter {
    static var twoDigits: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 2
        return formatter
    }
}
