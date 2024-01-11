//
//  DetailImageSetRow.swift
//  Timer
//
//  Created by lkh on 1/3/24.
//

import SwiftUI

// MARK: - DetailImageSetRow
struct DetailImageSetRow: View {
    // MARK: Binding
    @Binding var detailButton: DetailButton?
    @Binding var showPopup: Bool

    @Binding var preparationColor: Int
    @Binding var loopRestColor: Int
    
    // MARK: 프로퍼티
    let btn: DetailButton

    // MARK: - View
    var body: some View {
        // MARK: main
        if btn == .preparation {
            Button(action: {
                detailButton = .preparationColor
                showPopup.toggle()
            }, label: {
                ZStack {
                    Circle()
                        .fill(Color(preparationColor.IndexToColor))
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .stroke(Color.secondary)
                        .frame(width: 30, height: 30)
                } // ZStack
            })
            .buttonStyle(EffectButtonStyle())
            
        } else if btn == .loopRest {
            Button(action: {
                detailButton = .loopRestColor
                showPopup.toggle()
            }, label: {
                ZStack {
                    Capsule()
                        .fill(Color(loopRestColor.IndexToColor))
                        .frame(width: 30, height: 30)
                    
                    Capsule()
                        .stroke(Color.secondary)
                        .frame(width: 30, height: 30)
                }
            })
            .buttonStyle(EffectButtonStyle())

        } // if - else
    } // body
}

