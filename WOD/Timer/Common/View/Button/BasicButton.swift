//
//  basicButton.swift
//  Timer
//
//  Created by lkh on 12/26/23.
//

import SwiftUI

// MARK: - BasicButton
struct BasicButton: View {
    // MARK: 프로퍼티s
    let action: () -> Void
    let systemName: String?
    let text: String?
    
    // MARK: init
    init(action: (@escaping () -> Void), systemName: String, text: String? = nil) {
        self.action = action
        self.systemName = systemName
        self.text = text
    }
    
    init(action: (@escaping () -> Void), systemName: String? = nil, text: String) {
        self.action = action
        self.systemName = systemName
        self.text = text
    }
    
    // MARK: View
    var body: some View {
        Button(action: {
            action()
        }, label: {
            if let sysName = systemName {
                Image(systemName: sysName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    //.foregroundColor(.secondary)
            } else {
                Text(text ?? "")
            }
        })
        .buttonStyle(EffectButtonStyle())
        
    }
}

struct BasicButton_Previews: PreviewProvider {
    static var previews: some View {
        BasicButton(action: {},systemName: "plus.circle")
    }
}
