//
//  SimpleButtonSetRow.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleButtonSetRow
struct SimpleButtonSetRow: View {
    @Binding var simpleButton: SimpleButton?
    @Binding var showPopup: Bool
    @Binding var isModeBtn: Int
    
    let viewModel: SimpleViewModel
    let btn: SimpleButton
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            HStack(alignment: .center, spacing: 0) {
                Text(btn.buttonText)
                Spacer()
                Text(viewModel.displaySimpleSetValue(state: btn.buttonText, mode: isModeBtn))
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
