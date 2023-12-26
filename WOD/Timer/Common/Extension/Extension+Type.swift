//
//  Extension+String.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

// MARK: - String
extension String {
    // MARK: - timeToString
    static func timeToString(_ t: Double) -> String {
        let sec = Int(t)
        let minu = sec / 60
        let frac = Int((t - Double(sec)) * 100)
        return String(format: "%02d:%02d.%02d", minu, sec % 60, frac)
    }
}

// MARK: - Int
extension Int {
    // MARK: - asTimestamp
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

// MARK: - Date
extension Date {
    // MARK: - formatted
    // ex) Date().formatted("yyyy-MM-dd HH:mm:ss")
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        
        return formatter.string(from: self)
    }
}

// MARK: - Array
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Color
extension Color {
    // 배경색
    static let preparationColors = ["lightYellow1", "lightYellow2", "lightYellow3", "lightYellow4"]
    static let movementColors = ["lightBlue2", "lightBlue1", "lightBlue3", "lightBlue4"]
    static let restColors = ["lightGreen1", "lightGreen2", "lightGreen3", "lightGreen4"]
    
    // MARK: - randomPreparationColor
    static func randomPreparationColor() -> Color {
        guard let randomElement = preparationColors.randomElement() else {
            return .clear
        }
        return Color(randomElement)
    }
    
    // MARK: - randomMovementColor
    static func randomMovementColor() -> Color {
        guard let randomElement = movementColors.randomElement() else {
            return .clear
        }
        return Color(randomElement)
    }
    
    // MARK: - randomRestColor
    static func randomRestColor() -> Color {
        guard let randomElement = restColors.randomElement() else {
            return .clear
        }
        return Color(randomElement)
    }
}
