//
//  ControlButton.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct CommonButton: View {
    var systemName: String // SF Symbol 이름
    var bgColor: Color
    var imgColor: Color
    var opacity: CGFloat = 0.4
    var action: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                guard let action = action else { return }
                action()
            }) {
                ZStack {
                    Circle()
                        .strokeBorder(bgColor, lineWidth: 10)
                        .frame(
                            width: min(geometry.size.width, geometry.size.height),
                            height: min(geometry.size.width, geometry.size.height)
                        )
                        .opacity(opacity)
                        .overlay(
                            Image(systemName: systemName)
                                .resizable()
                                .frame(
                                    width: min(geometry.size.width, geometry.size.height) - 30,
                                    height: min(geometry.size.width, geometry.size.height) - 30
                                )
                                .foregroundColor(imgColor)
                            // aspectRatio 임마가 뒤로 와야 고정
                                .aspectRatio(contentMode: .fit)
                        )
                }
            }
            .buttonStyle(.plain)
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
        .scaledToFit()
    }
}
