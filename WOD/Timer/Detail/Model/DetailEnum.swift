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
    case rest
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
        case .rest:
            return "Rest"
        case .cycleRest:
            return "Rest between cycles"
        }
    }
}
