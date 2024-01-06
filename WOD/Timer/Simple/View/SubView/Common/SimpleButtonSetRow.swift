//
//  SimpleButtonSetRow.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleButtonSetRow
struct SimpleButtonSetRow: View {
    // MARK: Binding
    @Binding var simpleButton: SimpleButton?
    @Binding var showPopup: Bool
    @Binding var isModeBtn: Int
    
    // MARK: 프로퍼티
    let viewModel: SimpleViewModel
    let btn: SimpleButton
    
    // MARK: View
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(btn.buttonText)
                        .font(.headline)
                    Text(viewModel.displaySubText(state: btn.buttonText))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(viewModel.displaySimpleSetValue(state: btn.buttonText, mode: isModeBtn))
                    .monospacedDigit()
            }
            .contentShape(Rectangle())
        } // label
        ) // Button
        .buttonStyle(EffectButtonStyle())
    } // body
    
    // MARK: - methods
    // ...
    // MARK: - buttonAction
    private func buttonAction() {
        simpleButton = btn
        if !(isModeBtn == 1 && (btn == .movements || btn == .rest)) {
            showPopup.toggle()
        }
        return
    }
}
