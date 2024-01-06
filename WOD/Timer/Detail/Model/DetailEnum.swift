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
    case loop
    case preparation
    case loopRestColor
    case preparationColor
    case loopRest

    var buttonText: String {
        switch self {
        case .round:
            return "Round"
        case .loop:
            return "Movement loop"
        case .preparation:
            return "Preparation"
        case .loopRest:
            return "Rest"
            
        default:
            return "Color"
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

// MARK: - SimpleRoundPhase
enum DetailRoundPhase {
    case preparation
    case loopMovement
    case loopRest
    case rest
    case completed
    
    // 현재 라운드 단계를 문자열로
    var phaseText: String {
        switch self {
        case .preparation:
            return "Preparation"
        case .loopMovement:
            return "Movement"
        case .loopRest:
            return "Rest"
        case .rest:
            return "Rest"
        case .completed:
            return "Completed"
        }
    }
}
