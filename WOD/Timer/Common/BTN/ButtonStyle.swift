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
                .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
            Spacer()
            Text(text)
        }
    }
}

struct InsetRoundScaleButton: ButtonStyle {
  var labelColor = Color.white
  var backgroundColor = Color.blue
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(labelColor)
      .padding()
      .background(Capsule().fill(backgroundColor))
      .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
  }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}
