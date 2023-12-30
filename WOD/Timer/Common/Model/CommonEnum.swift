//
//  Enum.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI

// MARK: - ScenePhase
// 앱이 어디서 실행되는지 구분
enum ScenePhase {
    case active
    case inactive
    case background
}

// MARK: - Field
enum Field {
    case hh
    case mm
    case ss
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

// MARK: - AlertType
enum AlertType{
    case limitOne // 셋팅 1개
    case limitMoveMax // 셋팅 휴식 초과
    case limitRestMax // 셋팅 휴식 초과
    case save // 저장 메세지
    case quit // 뒤로 가기
    case restAdd // 휴식 초과 경고
    case empty // 비어있음
    case general // 일반
    case ready // 준비
}

