//
//  DetailViewModel+ViewTimer.swift
//  Timer
//
//  Created by lkh on 1/3/24.
//

import SwiftUI
import Foundation

// MARK: - DetailViewModel+View Timer
// 뷰에 나타내는 텍스트, 컬러 관련 연산 프로퍼티 및 메소드들
extension DetailViewModel {
    // MARK: - 연산 프로퍼티s
    // ..
    // MARK: - confirmationMessage
    var confirmationMessage: String {
        """
            Starting with current settings?\n
            Select Preparation: \(selectedPreparationAmount)
            Select Loop: \(setViewTempTotalLoopState())
            Select Rest: \(selectedRestAmount.totalSeconds)
            Total Round: \(selectedRoundAmount)\n
            Total Second: \(setViewTempTotalTime)
        """
    }
    
    // MARK: - nextTimerPhase
    var nextTimerPhase: String {
        guard let idx = detailTmRoundIdx, let phase = detailRoundPhase else {
            return "Nothing"
        }
        
        if idx + 1 < detailTmRounds.count && detailTmRounds[idx + 1].currentRound <= selectedRoundAmount {
            switch detailTmRounds[idx+1].currentPhase {
            case .preparation:
                return phase.phaseText
            case .loopMovement:
                return detailTmRounds[idx+1].title ?? "Movement"
            case .loopRest:
                return detailTmRounds[idx+1].title ?? "Rest in loop"
            case .rest:
                return detailTmRounds[idx+1].currentPhase.phaseText
            case .completed:
                return "END"
            }
            //return detailTmRounds[idx + 1].currentPhase.phaseText
        }
        
        return "END"
    }
    
    // MARK: - nextTimerTime
    var nextTimerTime: String {
        guard let idx = detailTmRoundIdx else {
            return "00:00"
        }
        
        if idx + 1 < detailTmRounds.count &&  detailTmRounds[idx + 1].currentRound <= selectedRoundAmount {
            return detailTmRounds[idx + 1].time.totalSeconds.asTimestamp
        }
        
        return "END"
    }
    
    // MARK: - currentTimerRoundDisplay
    var currentTimerRoundDisplay: String {
        guard let idx = detailTmRoundIdx else {
            return "Nothing"
        }
        if idx < detailTmRounds.count {
            return "\(detailTmRounds[idx].currentRound) Round"
        }
        return "Completed"
    }
    
    // MARK: - currentTimerRoundString
    var currentTimerRoundString: String {
        detailTmRoundIdx ?? 0 < selectedRoundAmount ? "\((detailTmRoundIdx ?? 0) + 1)" : "\(selectedRoundAmount)"
    }
    
    // MARK: - currentPhaseText
    var currentTimerTitle: String {
        guard let idx = detailTmRoundIdx, let phase = detailRoundPhase else {
            return "Nothing"
        }
        
        switch phase {
        case .preparation:
            return phase.phaseText
        case .loopMovement:
            return detailTmRounds[idx].title ?? "Movement"
        case .loopRest:
            return detailTmRounds[idx].title ?? "Rest in loop"
        case .rest:
            return phase.phaseText
        case .completed:
            return "END"
        }
    }
    
    // MARK: - currentTimerDisplayTime
    var currentTimerDisplayTime: String {
        guard let idx = detailTmRoundIdx else {
            return "END"
        }
        
        if detailTmRounds[idx].currentRound <= selectedRoundAmount {
            return detailDisplay.asTimestamp
        }
        return "END"
    }
    
    // MARK: - currentTimerRemainingString
    var currentTimerRemainingString: String {
        "\(selectedRoundAmount - ((detailTmRoundIdx ?? 0) + 1))"
    }
    
    // MARK: - currentRemainingRounds
    var currentTimerRemainingRounds: String {
        guard let idx = detailTmRoundIdx else {
            return "Nothing"
        }
        
        return "Remaining \(selectedRoundAmount - detailTmRounds[idx].currentRound)"
    }
    
    // MARK: - isDisplayToolbarTmBtn
    var isDisplayToolbarTmBtn: Bool {
        guard let idx = detailTmRoundIdx else { return true }
        
        return detailTimerState == .paused || idx == detailTmRounds.count || detailTimerState == .completed
    }
    
    // MARK: - isTmEnd
    var isTmEnd: Color {
        guard let phase = detailRoundPhase else { return .clear }
        
        return phase != .completed ? Color(.black).opacity(0.3) : phaseBackgroundColor
    }
    
    // MARK: - in using
    // ...
    // MARK: - setViewTempTotalTime
    private var setViewTempTotalTime: Int {
        timerLoopList.reduce(0) { $0 + $1.time.totalSeconds } * selectedRoundAmount + selectedLoopRestAmount.totalSeconds * (selectedRoundAmount - 1)
    }
    
    // MARK: - setViewTempTotalLoopState
    private func setViewTempTotalLoopState() -> String {
        var ret: String = "Exercise: \(timerLoopList.filter {$0.type == .movement}.count)"
        
        let inLoopRestCount = timerLoopList.filter { $0.type == .rest }.count
        if inLoopRestCount > 0 { ret += " Rest: \(inLoopRestCount)" }
        
        return ret
    }
}
