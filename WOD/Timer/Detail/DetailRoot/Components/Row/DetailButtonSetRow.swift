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
    
    // MARK: 프로퍼티s
    let viewModel: DetailViewModel
    let btn: DetailButton
    
    // MARK: View
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            HStack(alignment: .center, spacing: 15) {
                if btn == .loop || btn == .round {
                    if btn == .loop {
                        Image(systemName: "clock.arrow.circlepath")
                            .resizable()
                            .foregroundColor(Color("lightBlue1"))
                            .frame(width: 30, height: 30)
                    } else {
                        Image(systemName: "clock.arrow.2.circlepath")
                            .resizable()
                            .foregroundColor(Color("lightBlue1"))
                            .frame(width: 30, height: 30)
                    }
                } // if btn == .loop || btn == .round
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(btn.buttonText)
                        .font(.headline)
                    
                    Text("\(viewModel.displaySubText(state: btn.buttonText))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } // VStack
                Spacer()
                
                if btn != .loop {
                    Text(viewModel.displayDetailSetValue(state: btn.buttonText, mode: isModeBtn))
                        .monospacedDigit()
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                } // if - else
            } // HStack
            .contentShape(Rectangle())
        }) // Button
        .buttonStyle(EffectButtonStyle())
    } // body
    
    // MARK: - methods
    // ...
    // MARK: - buttonAction
    private func buttonAction() {
        detailButton = btn
        
        if btn == .preparation || btn == .round {
            showPopup.toggle()
        } else if isModeBtn == 0 && btn == .loopRest {
            showPopup.toggle()
        } else if btn == .loop {
            rootView.toggle()
        }
        
        return
    }
}

