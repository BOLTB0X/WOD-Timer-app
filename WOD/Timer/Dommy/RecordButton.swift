//
//  RecordButton.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct RecordButton: View {
    var mode: StopWatchViewModel.Mode
    
    var action: (() -> Void)?
    
    private let systemName: String = "checkmark.circle.fill"
    
    private var opacity: CGFloat { mode == .stopped ? 0.4 : 0.8 }
    
    private var bgColor: Color {
        mode == .running ? .orange : .gray
    }
    private var imgColor: Color {
        mode == .running ? .orange : .gray
    }
    
    var body: some View {
        CommonButton(systemName: systemName, bgColor: bgColor, imgColor: imgColor, action: action)
    }
}

