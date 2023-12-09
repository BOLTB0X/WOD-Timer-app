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
    case active // 실행
    case paused // 중단
    case resumed // 재개
    case cancelled // 취소
    case completed // 완료
    
    // 현재 타이머 상태를 문자열로
    var statusText: String {
         switch self {
         case .active:
             return "Active"
         case .paused:
             return "Paused"
         case .resumed:
             return "Resumed"
         case .cancelled:
             return "Cancelled"
         case .completed:
             return "Completed"
         }
     }
}

// MARK: - SimpleRoundPhase
enum SimpleRoundPhase {
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
