//
//  SimpleViewModel+ViewStopwatch.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI
import Foundation

// MARK: - SimpleViewModel + View Stopwatch
// 뷰에 나타내는 텍스트, 컬러 관련 연산 프로퍼티 
extension SimpleViewModel {
    // MARK: - 연산 프로퍼티s
    // ...
    
    // MARK: - confirmationStopMessage
    var confirmationStopMessage: String {
        return """
            Are you sure you want to start?
            Total Round: \(selectedRoundStop)
            Select Preparation: \(selectedPreparationStop)
            """
    }
    
    // MARK: - nextStopPhase
    var nextStopPhase: String {
        guard let currentRoundIdx = simpleSwRoundIdx,
              currentRoundIdx < simpleSwRounds.count else {
            return "END"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return "Movement"
        case .movement:
            return currentRoundIdx != simpleSwRounds.count - 1 ? "Rest" : "Rest X"
        case .rest:
            return "Movement"
        default:
            return "END"
        }
    }
    
    // MARK: - nextStopTime
    var nextStopTime: String {
        guard let currentRoundIdx = simpleSwRoundIdx,
              currentRoundIdx < simpleSwRounds.count else {
            return "00:00"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return simpleSwRounds[currentRoundIdx].movement.asTimestamp
        case .movement:
            if simpleSwRounds[currentRoundIdx].rest > 0 {
                return simpleSwRounds[currentRoundIdx].rest.asTimestamp
            } else {
                return "END"
            }
        case .rest:
            if currentRoundIdx + 1 < simpleSwRounds.count {
                return simpleSwRounds[currentRoundIdx].movement.asTimestamp
            } else {
                return "NEXT"
            }
        default:
            return "END"
        }
    }
    
    // MARK: - currentTimerRoundDisplay
    var currentStopRoundDisplay: String {
        simpleSwRoundIdx ?? 0 < selectedRoundStop ? "\((simpleSwRoundIdx ?? 0) + 1) Round" : "\(selectedRoundStop) Round"
    }
    
    // MARK: - currentStopRoundString
    var currentStopRoundString: String {
        simpleSwRoundIdx ?? 0 < selectedRoundStop ? "\((simpleSwRoundIdx ?? 0) + 1)" : "\(selectedRoundStop)"
    }
    
    // MARK: - currentStopDisplayTime
    var currentStopDisplayTime: String {
        simpleSwRoundIdx ?? 0 < selectedRoundStop ? simpleDisplay.asTimestamp : "END"
    }
    
    // MARK: - currentStopRemainingString
    var currentStopRemainingString: String {
        "\(selectedRoundStop - ((simpleSwRoundIdx ?? 0) + 1))"
    }
    
    // MARK: - currentStopRemainingRounds
    var currentStopRemainingRounds: String {
        switch simpleRoundPhase {
        case .preparation:
            return "Remaining: \(selectedRoundStop) Round"
        default:
            return "Remaining: \(selectedRoundStop - ((simpleSwRoundIdx ?? 0) + 1)) Round"
        }
    }
    
    // MARK: - isDisplayToolbarSwBtn
    var isDisplayToolbarSwBtn: Bool {
        simpleStopState == .paused || simpleSwRoundIdx ?? 0 == selectedRoundStop
    }
    
    // MARK: - isSwEnd
    var isSwEnd: Color {
        simpleSwRoundIdx ?? 0 < simpleSwRounds.count ? Color(.black).opacity(0.3) : phaseBackgroundColor
    }
}
