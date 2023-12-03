//
//  ControlButton.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import SwiftUI

struct ControlButton: View {
    @State private var isPaused: Bool = false
    var action: (() -> Void)?
    let img1Name: String?
    let img2Name: String?
    let defaultImgName: String?
    
    init(action: (@escaping () -> Void), img1Name: String?, img2Name: String?, defaultImgName: String? = nil) {
        self.action = action
        self.img1Name = img1Name
        self.img2Name = img2Name
        self.defaultImgName = nil
    }
    
    init(action: (@escaping () -> Void), img1Name: String? = nil, img2Name: String? = nil, defaultImgName: String) {
        self.action = action
        self.img1Name = nil
        self.img2Name = nil
        self.defaultImgName = defaultImgName
    }
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Button(action: {
                    isPaused.toggle()
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
            }
        }
        .scaledToFit()
    }
}

//#Preview {
//    ControlButton(action: {})
//}
