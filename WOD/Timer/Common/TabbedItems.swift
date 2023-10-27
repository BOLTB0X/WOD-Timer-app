//
//  TabbedItems.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import Foundation

enum TabbedItems: Int, CaseIterable{
    case WOD = 0
    case Passivity
    case Timer
    case Profile
    
    var title: String{
        switch self {
        case .WOD:
            return "WOD/Interval"
        case .Passivity:
            return "Passivity"
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
        case .Passivity:
            return "figure.strengthtraining.traditional"
        case .Timer:
            return "timer"
        case .Profile:
            return "person.crop.circle"
        }
    }
}
