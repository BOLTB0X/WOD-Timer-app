//
//  SimpleRow.swift
//  Timer
//
//  Created by lkh on 11/12/23.
//

import SwiftUI

//struct SimpleRow: View {
//    @Binding var selectedRoundAmount: Int
//    @Binding var selectedPreparationAmount: Int
//    @Binding var selectedMovementAmount: MovementTime
//    @Binding var selectedRestAmount: Int
//    @Binding var simpleButton: SimpleButton?
//    @Binding var showPopup: Bool
//    
//    private let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
//    
//    private var setValue: String {
//        switch simpleButton {
//        case .round:
//            return "\(selectedRoundAmount)"
//        case .preparation:
//            return "\(selectedPreparationAmount)"
//        case .movements:
//            return "\(selectedMovementAmount)"
//        case .rest:
//            return "\(selectedRestAmount)"
//        default:
//            return ""
//        }
//    }
//    
//    var body: some View {
//        ForEach(simpleArr, id: \.self) { btn in
//            HStack(alignment: .center, spacing: 0) {
//                Text(setValue)
//                
//                Button(btn.buttonText) {
//                    simpleButton = btn
//                    showPopup.toggle()
//                }
//                .buttonStyle(EffectButtonStyle())
//            }
//        }
//    }
//}


