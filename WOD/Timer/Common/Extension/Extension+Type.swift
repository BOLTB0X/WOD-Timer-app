//
//  Extension+String.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

extension String {
    static func timeToString(_ t: Double) -> String {
        let sec = Int(t)
        let minu = sec / 60
        let frac = Int((t - Double(sec)) * 100)
        return String(format: "%02d:%02d.%02d", minu, sec % 60, frac)
    }
}

extension Int {
    var asTimestamp: String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60
        
        if hour > 0 {
            return String(format: "%02i:%02i:%02i", hour, minute, second)
        } else {
            return String(format: "%02i:%02i", minute, second)
        }
    }
}

extension Color {
    // 배경색
    static let preparationColors = ["lightYellow1", "lightYellow2", "lightYellow3", "lightYellow4"]
    static let movementColors = ["lightBlue2", "lightBlue1", "lightBlue3", "lightBlue4"]
    static let restColors = ["lightGreen1", "lightGreen2", "lightGreen3", "lightGreen4"]
    
    static func randomPreparationColor() -> Color {
        guard let randomElement = preparationColors.randomElement() else {
            return .clear
        }
        return Color(randomElement)
    }
    
    static func randomMovementColor() -> Color {
        guard let randomElement = movementColors.randomElement() else {
            return .clear
        }
        return Color(randomElement)
    }
    
    static func randomRestColor() -> Color {
        guard let randomElement = restColors.randomElement() else {
            return .clear
        }
        return Color(randomElement)
    }
}
