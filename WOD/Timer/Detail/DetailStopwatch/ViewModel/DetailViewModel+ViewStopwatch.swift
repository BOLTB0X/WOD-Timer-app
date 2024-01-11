//
//  DetailViewModel+ViewStopwatch.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI
import Foundation

// MARK: - DetailViewModel+View Stopwatch
// 뷰에 나타내는 텍스트, 컬러 관련 연산 프로퍼티 및 메소드들
extension DetailViewModel {
    // MARK: - 연산 프로퍼티s
    // ..
    // MARK: - confirmationMessageStop
    var confirmationMessageStop: String {
        """
            Starting with current settings?\n
            Select Preparation: \(selectedPreparationStop)
            Select Loop: \(setViewTempTotalLoopState())
            Total Round: \(selectedRoundStop)\n
        """
    }
    
    // MARK: - nextStopPhase
    var nextStopPhase: String {
        guard let idx = detailSwRoundIdx, let phase = detailRoundPhase else {
            return "Nothing"
        }
        
        if idx + 1 < detailSwRounds.count && detailSwRounds[idx + 1].currentRound <= selectedRoundStop {
            switch phase {
            case .preparation:
                return detailSwRounds[idx+1].title ?? "Movement"
            case .loopMovement:
                return detailSwRounds[idx+1].title ?? "Movement"
            case .loopRest:
                return detailSwRounds[idx+1].title ?? "Rest in loop"
            case .rest:
                return phase.phaseText
            case .completed:
                return "END"
            }
        }
        return "END"
    }
    
    // MARK: - nextStopTime
    var nextStopTime: String {
        guard let idx = detailSwRoundIdx else {
            return "00:00"
        }
        
        if idx + 1 < detailSwRounds.count &&  detailSwRounds[idx + 1].currentRound <= selectedRoundStop {
            return detailSwRounds[idx + 1].time.totalSeconds.asTimestamp
        }
        return "END"
    }
    
    // MARK: - currentStopRoundDisplay
    var currentStopRoundDisplay: String {
        guard let idx = detailSwRoundIdx else {
            return "Nothing"
        }
        if idx < detailSwRounds.count {
            return "\(detailSwRounds[idx].currentRound) Round"
        }
        return "Completed"
    }
    
    // MARK: - currentStopRoundString
    var currentStopRoundString: String {
        detailSwRoundIdx ?? 0 < selectedRoundStop ? "\((detailSwRoundIdx ?? 0) + 1)" : "\(selectedRoundStop)"
    }
    
    // MARK: - currentStopwatchTitle
    var currentStopwatchTitle: String {
        guard let idx = detailSwRoundIdx, let phase = detailRoundPhase else {
            return "Nothing"
        }
        
        switch phase {
        case .preparation:
            return phase.phaseText
        case .loopMovement:
            return detailSwRounds[idx].title ?? "Movement"
        case .loopRest:
            return detailSwRounds[idx].title ?? "Rest in loop"
        case .rest:
            return phase.phaseText
        case .completed:
            return "END"
        }
    }
    
    // MARK: - currentStopDisplayTime
    var currentStopDisplayTime: String {
        guard let idx = detailSwRoundIdx else {
            return "END"
        }
        
        if detailSwRounds[idx].currentRound <= selectedRoundStop {
            return detailDisplay.asTimestamp
        }
        return "END"
    }
    
    // MARK: - currentStopRemainingString
    var currentStopRemainingString: String {
        "\(selectedRoundStop - ((detailSwRoundIdx ?? 0) + 1))"
    }
    
    // MARK: - currentStopRemainingRounds
    var currentStopRemainingRounds: String {
        guard let idx = detailSwRoundIdx else {
            return "Nothing"
        }
        
        return "Remaining \(selectedRoundStop - detailSwRounds[idx].currentRound)"
    }
    
    // MARK: - isDisplayToolbarSwBtn
    var isDisplayToolbarSwBtn: Bool {
        guard let idx = detailSwRoundIdx else { return true }
        
        return detailStopState == .paused || idx == detailSwRounds.count || detailStopState == .completed
    }
    
    // MARK: - setViewTempTotalLoopState
    private func setViewTempTotalLoopState() -> String {
        var ret: String = "Exercise: \(stopLoopList.filter {$0.type == .movement}.count)"
        
        let inLoopRestCount = stopLoopList.filter { $0.type == .rest }.count
        if inLoopRestCount > 0 { ret += " Rest: \(inLoopRestCount)" }
        
        return ret
    }
}

