//
//  Enum.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import Foundation

// MARK: - SimpleButton
// 각 버튼 별
enum SimpleButton {
    case round
    case preparation
    case movements
    case rest

    var buttonText: String {
        switch self {
        case .round:
            return "Round"
        case .preparation:
            return "Preparation"
        case .movements:
            return "Movement"
        case .rest:
            return "Rest"
        }
    }
}

// MARK: - SimpleRoundPhase
enum SimpleRoundPhase: Codable {
    case preparation
    case movement
    case rest
    case completed
    
    // 현재 라운드 단계를 문자열로
    var phaseText: String {
        switch self {
        case .preparation:
            return "Preparation"
        case .movement:
            return "Movement"
        case .rest:
            return "Rest"
        case .completed:
            return "Completed"
        }
    }
}
