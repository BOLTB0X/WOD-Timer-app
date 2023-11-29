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
            return "Movements"
        case .rest:
            return "Rest"
        }
    }
}

// MARK: - ScenePhase
// 앱이 어디서 실행되는지 구분
enum ScenePhase {
    case active
    case inactive
    case background
}

// MARK: - TimerState
// 타이머 실행 단계
enum TimerState {
    case active
    case paused
    case resumed
    case cancelled
    case completed
}

// MARK: - SimpleRoundPhase
enum SimpleRoundPhase {
    case preparation
    case movement
    case rest
}
