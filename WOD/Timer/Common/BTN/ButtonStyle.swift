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

struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .opacity(configuration.isPressed ? 0.8 : 1.0)
            )
            .foregroundColor(.white)
            .frame(width: .infinity, height: .infinity)
    }
}
