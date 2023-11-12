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
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Spacer()
                TextField("Round", value: $setBinding, format: .number)
                    .textFieldStyle(CommonTextfieldStyle())
                    .focused($focusedField)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            focusedField = false
        }
    }
}

//#Preview {
//    SettingTextField()
//}
