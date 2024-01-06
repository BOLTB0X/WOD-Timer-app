//
//  CheckButton.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - CheckButton
struct CheckButton: View {
    // MARK: Binding
    @Binding var click: Bool
    
    // MARK: 프로퍼티s
    let systemName: String
    
    // MARK: init
    init(click: Binding<Bool>, systemName: String) {
        self._click = click
        self.systemName = systemName
    }
    
    // MARK: View
    var body: some View {
        Button(action: {
            click.toggle()
        }, label: {
            Image(systemName: systemName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(click ? .blue : .secondary)
        })
    }
}

struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckButton(click: .constant(false), systemName: "checkmark.square")
    }
}

