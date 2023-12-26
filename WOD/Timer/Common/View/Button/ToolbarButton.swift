//
//  ToolbarButton.swift
//  Timer
//
//  Created by lkh on 12/9/23.
//

import SwiftUI

struct ToolbarButton: View {
    var action: () -> Void
    var condition: Bool
    let systemName: String
    
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
