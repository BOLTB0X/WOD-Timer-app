//
//  RadioButton.swift
//  Timer
//
//  Created by lkh on 12/28/23.
//

import SwiftUI

// MARK: - RadioButton
struct RadioButton: View {
    // MARK: Binding
    @Binding var isTouch: Bool
    
    // MARK: 프로퍼티
    let action: (() -> Void)?
    let imgName1: String = "circle"
    let imgName2: String = "checkmark.circle.fill"
    
    // MARK: init
    init(isTouch: Binding<Bool>) {
        self._isTouch = isTouch
        self.action = nil
    }
    
    init(isTouch: Binding<Bool>, action: (@escaping () -> Void)) {
        self._isTouch = isTouch
        self.action = action
    }
    
    // MARK: View
    var body: some View {
        Button(action: {
            isTouch.toggle()
            if let act = action {
                act()
            }
        }) {
            Image(systemName: !isTouch ? imgName1 : imgName2)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.secondary)
        }
    } // body
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(isTouch: .constant(false))
    }
}


