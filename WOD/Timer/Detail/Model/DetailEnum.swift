//
//  DetailEnum.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import Foundation

// MARK: - DetailButton
// 각 버튼 별
enum DetailButton {
    case round
    case cycle
    case preparation
    case movements
    case moverest
    case cycleRest

    var buttonText: String {
        switch self {
        case .round:
            return "Round"
        case .cycle:
            return "Cycle"
        case .preparation:
            return "Preparation"
        case .movements:
            return "Movements"
        case .moverest:
            return "moveRest"
        case .cycleRest:
            return "Rest"
        }
    }
}

// MARK: - SelectedSetting
enum SelectedSetting {
    case color
    case time
    case text
    case defaultMoveColor
    case defaultMoveTime
    case defaultMoveText
    case defaultRestColor
    case defaultRestTime
    case defaultRestText
}

// MARK: - DetailItemType
enum DetailItemType {
    case movement
    case rest
}
