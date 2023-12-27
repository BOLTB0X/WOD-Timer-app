//
//  ToolbarButton.swift
//  Timer
//
//  Created by lkh on 12/9/23.
//

import SwiftUI

// MARK: - ToolbarButton
struct ToolbarButton: View {
    // MARK: 프로퍼티
    var action: () -> Void
    var condition: Bool
    let systemName: String
    
    // MARK: View
    var body: some View {
        Button(action: {
            action()
        }) {
            if condition {
                Image(systemName: systemName)
            }
        }
        .buttonStyle(EffectButtonStyle())
    }
}
