//
//  WodViewModel+View.swift
//  Timer
//
//  Created by lkh on 11/30/23.
//

import SwiftUI
import Foundation

// MARK: - SimpleViewModel+View Timer
// 뷰에 나타내는 텍스트, 컬러 관련 연산 프로퍼티 및 메소드들
extension SimpleViewModel {
    // MARK: - 연산 프로퍼티s
    // ..
    // MARK: - confirmationMessage
    var confirmationMessage: String {
        return """
            Are you sure you want to start?
            Total Round: \(selectedRoundAmount)
            Select Preparation: \(selectedPreparationAmount)
            Select Movement: \(String(format: "%02d:%02d:%02d", selectedMovementAmount.hours, selectedMovementAmount.minutes, selectedMovementAmount.seconds))
            Select Rest: \(selectedRestAmount.totalSeconds)
            Total Second: \(selectedRoundAmount * (selectedMovementAmount.hours + selectedMovementAmount.minutes + selectedMovementAmount.seconds + selectedRestAmount.totalSeconds) - selectedRestAmount.totalSeconds)
            """
    }
    
    // MARK: - nextTimerPhase
    var nextTimerPhase: String {
        guard let currentRoundIdx = simpleTmRoundIdx,
              currentRoundIdx < simpleTmRounds.count else {
            return "END"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return "Movement"
        case .movement:
            return currentRoundIdx != simpleTmRounds.count - 1 ? "Rest" : "Rest X"
        case .rest:
            return "Movement"
        default:
            return "END"
        }
    }
        
    // MARK: - nextTimerTime
    var nextTimerTime: String {
        guard let currentRoundIdx = simpleTmRoundIdx,
              currentRoundIdx < simpleTmRounds.count else {
            return "00:00"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return simpleTmRounds[currentRoundIdx].movement.asTimestamp
        case .movement:
            if simpleTmRounds[currentRoundIdx].rest > 0 {
                return simpleTmRounds[currentRoundIdx].rest.asTimestamp
            } else {
                return "END"
            }
        case .rest:
            if currentRoundIdx + 1 < simpleTmRounds.count {
                return simpleTmRounds[currentRoundIdx].movement.asTimestamp
            } else {
                return "NEXT"
            }
        default:
            return "END"
        }
    }
    
    // MARK: - currentTimerRoundDisplay
    var currentTimerRoundDisplay: String {
        simpleTmRoundIdx ?? 0 < selectedRoundAmount ? "\((simpleTmRoundIdx ?? 0) + 1) Round" : "\(selectedRoundAmount) Round"
    }
    
    // MARK: - currentTimerRoundString
    var currentTimerRoundString: String {
        simpleTmRoundIdx ?? 0 < selectedRoundAmount ? "\((simpleTmRoundIdx ?? 0) + 1)" : "\(selectedRoundAmount)"
    }
    
    // MARK: - currentPhaseText
    var currentPhaseText: String {
        simpleRoundPhase?.phaseText ?? ""
    }
    
    // MARK: - currentTimerDisplayTime
    var currentTimerDisplayTime: String {
        simpleTmRoundIdx ?? 0 < selectedRoundAmount ? simpleDisplay.asTimestamp : "END"
    }
    
    // MARK: - currentTimerRemainingString
    var currentTimerRemainingString: String {
        "\(selectedRoundAmount - ((simpleTmRoundIdx ?? 0) + 1))"
    }
    
    // MARK: - currentRemainingRounds
    var currentTimerRemainingRounds: String {
        switch simpleRoundPhase {
        case .preparation:
            return "Remaining: \(selectedRoundAmount) Round"
        default:
            return "Remaining: \(selectedRoundAmount - ((simpleTmRoundIdx ?? 0) + 1)) Round"
        }
    }
    
    // MARK: - isDisplayToolbarTmBtn
    var isDisplayToolbarTmBtn: Bool {
        simpleTimerState == .paused || simpleTmRoundIdx ?? 0 == selectedRoundAmount
    }
    
    // MARK: - isTmEnd
    var isTmEnd: Color {
        simpleTmRoundIdx ?? 0 < simpleTmRounds.count ? Color(.black).opacity(0.3) : phaseBackgroundColor
    }
}
