//
//  OnboardingButtonStyle.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

struct EffectButtonStyle: ButtonStyle {
    let text: String
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            //        .foregroundColor(labelColor)
            //        .padding()
            //        .background(Capsule().fill(backgroundColor))
                .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
            
            Text(text)
        }
    }
}
