//
//  ControlButton.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import SwiftUI

// MARK: - ControlButton
struct ControlButton: View {
    // MARK: Binding
    @Binding var isPaused: Bool
    
    // MARK: 프로퍼티s
    var action: (() -> Void)?
    let img1Name: String?
    let img2Name: String?
    let defaultImgName: String?
    
    // MARK: init
    init(isPaused: Binding<Bool>, action: (@escaping () -> Void), img1Name: String?, img2Name: String?, defaultImgName: String? = nil) {
        self._isPaused = isPaused
        self.action = action
        self.img1Name = img1Name
        self.img2Name = img2Name
        self.defaultImgName = nil
    }
    
    init(isPaused: Binding<Bool>, action: (@escaping () -> Void), img1Name: String? = nil, img2Name: String? = nil, defaultImgName: String) {
        self._isPaused = isPaused
        self.action = action
        self.img1Name = nil
        self.img2Name = nil
        self.defaultImgName = defaultImgName
    }
    
    // MARK: View
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Button(action: {
                    guard let action = action else { return }
                    action()
                }) {
                    if defaultImgName == nil {
                        Image(systemName: isPaused ? img1Name ?? "" : img2Name ?? "")
                            .resizable()
                            .frame(
                                width: min(geometry.size.width, geometry.size.height) - 70,
                                height: min(geometry.size.width, geometry.size.height)  - 70
                            )
                    } else {
                        Image(systemName: defaultImgName ?? "")
                            .resizable()
                            .frame(
                                width: min(geometry.size.width, geometry.size.height) - 70,
                                height: min(geometry.size.width, geometry.size.height)  - 70
                            )
                    }
                }
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                .buttonStyle(EffectButtonStyle())
            } // ZStack
        } // GeometryReader
    }
}

