//
//  TabEum.swift
//  TImerB0X
//
//  Created by KyungHeon Lee on 2023/10/25.
//

import Foundation

enum TabbedItems: Int, CaseIterable{
    case WOD = 0
    case Strength
    case Timer
    case Profile
    
    var title: String{
        switch self {
        case .WOD:
            return "WOD/Interval"
        case .Strength:
            return "Strength"
        case .Timer:
            return "Timer"
        case .Profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .WOD:
            return "figure.highintensity.intervaltraining"
        case .Strength:
            return "figure.strengthtraining.traditional"
        case .Timer:
            return "timer"
        case .Profile:
            return "person.crop.circle"
        }
    }
}
