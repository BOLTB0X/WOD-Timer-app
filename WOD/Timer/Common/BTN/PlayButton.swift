//
//  PlayButton.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct PlayButton: View {
    var mode: GeneralViewModel.Mode
    
    var action: (() -> Void)?
    
    private var systemName: String {
        mode == .running ? "pause.circle" : "play.circle"
    }
    
    private let opacity: CGFloat = 0.3
    
    private var bgColor: Color {
        mode == .running ? .blue : .gray
    }
    private var imgColor: Color {
        mode == .running ? .blue : .gray
    }
    
    var body: some View {
        CommonButton(systemName: systemName, bgColor: bgColor, imgColor: imgColor, action: action)
    }
}

#Preview {
    Group {
        PlayButton(mode: .stopped)
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Mode: Stopped")
        
        PlayButton(mode: .running)
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Mode: Stopped")
        
        PlayButton(mode: .paused)
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Mode: Stopped")
    }
}
