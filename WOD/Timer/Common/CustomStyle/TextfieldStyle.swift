//
//  TextfieldStyle.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

// MARK: - CommonTextfieldStyle
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
        } // ZStack
    } // body
}

// MARK: titleTextfieldStyle
struct titleTextfieldStyle: TextFieldStyle {
    // MARK: Binding
    @Binding var input: String
    
    // MARK: 연산 프로퍼티s
    private var strokeWidth: CGFloat {
        if input.count >= 20 {
            return 2.0
        } else {
            return 1.0
            
        }
    }
    
    private var strokeColor: Color {
        if input.count >= 20 {
            return Color(.red)
        } else {
            return Color(.gray)
        }
    }
    
    // MARK: - View
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .stroke(strokeColor, lineWidth: strokeWidth)
                .foregroundColor(Color.gray.opacity(0.1))
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                .frame(height: 80)
            
            HStack {
                // 텍스트필드
                configuration
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .font(.system(size: 50))
                    .multilineTextAlignment(.leading)
                
                if input.count > 0 {
                    Button(action: {
                        self.input = ""
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.secondary)
                    })
                } // if
            } // HStack
            .padding(.horizontal)
        } // ZStack
    } // body
}
