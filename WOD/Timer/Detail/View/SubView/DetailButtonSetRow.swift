//
//  DetailButtonSetRow.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailButtonSetRow
struct DetailButtonSetRow: View {
    // MARK: Binding
    @Binding var detailButton: DetailButton?
    @Binding var showPopup: Bool
    @Binding var rootView: Bool
    @Binding var isModeBtn: Int
    
    // MARK: 프로퍼티
    let viewModel: DetailViewModel
    let btn: DetailButton
    
    // MARK: View
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            HStack(alignment: .center, spacing: 0) {
                
                Text(btn.buttonText)
                
                Spacer()
            }
            .contentShape(Rectangle())
        }) // Button
        .buttonStyle(EffectButtonStyle())
    } // body
    
    // MARK: - methods
    // ...
    // MARK: - buttonAction
    private func buttonAction() {
        detailButton = btn
        if btn == .preparation || btn == .cycleRest || btn == .round {
            showPopup.toggle()
        } else if btn == .cycle {
            rootView.toggle()
        }
        return
    }
}

