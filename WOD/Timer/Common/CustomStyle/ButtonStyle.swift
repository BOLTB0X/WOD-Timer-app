//
//  OnboardingButtonStyle.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

// MARK: - EffectButtonStyle
struct EffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            //.frame(maxWidth: .infinity)
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}



// MARK: - BlueButtonStyle
struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBlue)))
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}

