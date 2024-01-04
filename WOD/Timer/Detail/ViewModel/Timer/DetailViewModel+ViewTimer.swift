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
        guard let currentRoundIdx = detailTmRoundIdx,
              currentRoundIdx < detailTmRounds.count else {
            return "END"
        }
        
        switch detailRoundPhase {
        case .preparation:
            return "Movement"
        case .movement:
            return currentRoundIdx != detailTmRounds.count - 1 ? "Rest" : "Rest X"
        case .rest:
            return "Movement"
        default:
            return "END"
        }
    }
    
    // MARK: - nextTimerTime
    var nextTimerTime: String {
        guard let currentRoundIdx = detailTmRoundIdx,
              currentRoundIdx < detailTmRounds.count else {
            return "00:00"
        }
        
        switch detailRoundPhase {
        case .preparation:
            return detailTmRounds[currentRoundIdx].movement[selectedTimerLoopIndex].time.totalSeconds.asTimestamp
        case .movement:
            if detailTmRounds[currentRoundIdx].movement[selectedTimerLoopIndex].time.totalSeconds > 0 {
                return detailTmRounds[currentRoundIdx].movement[selectedTimerLoopIndex].time.totalSeconds.asTimestamp
            } else {
                return "END"
            }
        case .rest:
            if currentRoundIdx + 1 < detailTmRounds.count {
                return detailTmRounds[currentRoundIdx].movement[selectedTimerLoopIndex].time.totalSeconds.asTimestamp
            } else {
                return "NEXT"
            }
        default:
            return "END"
        }
    }
    
    // MARK: - currentTimerRoundDisplay
    var currentTimerRoundDisplay: String {
        detailTmRoundIdx ?? 0 < selectedRoundAmount ? "\((detailTmRoundIdx ?? 0) + 1) Round" : "\(selectedRoundAmount) Round"
    }
    
    // MARK: - currentTimerRoundString
    var currentTimerRoundString: String {
        detailTmRoundIdx ?? 0 < selectedRoundAmount ? "\((detailTmRoundIdx ?? 0) + 1)" : "\(selectedRoundAmount)"
    }
    
    // MARK: - currentPhaseText
    var currentPhaseText: String {
        detailRoundPhase?.phaseText ?? ""
    }
    
    // MARK: - currentTimerDisplayTime
    var currentTimerDisplayTime: String {
        detailTmRoundIdx ?? 0 < selectedRoundAmount ? detailDisplay.asTimestamp : "END"
    }
    
    // MARK: - currentTimerRemainingString
    var currentTimerRemainingString: String {
        "\(selectedRoundAmount - ((detailTmRoundIdx ?? 0) + 1))"
    }
    
    // MARK: - currentRemainingRounds
    var currentTimerRemainingRounds: String {
        switch detailRoundPhase {
        case .preparation:
            return "Remaining: \(selectedRoundAmount) Round"
        default:
            return "Remaining: \(selectedRoundAmount - ((detailTmRoundIdx ?? 0) + 1)) Round"
        }
    }
    
    // MARK: - isDisplayToolbarTmBtn
    var isDisplayToolbarTmBtn: Bool {
        detailState == .paused || detailTmRoundIdx ?? 0 == selectedRoundAmount
    }
    
    // MARK: - isTmEnd
    var isTmEnd: Color {
        detailTmRoundIdx ?? 0 < detailTmRounds.count ? Color(.black).opacity(0.3) : phaseBackgroundColor
    }
        
    // MARK: - setViewTempTotalTime
    private var setViewTempTotalTime: Int {
        timerLoopList.reduce(0) { $0 + $1.time.totalSeconds } * selectedRoundAmount + selectedLoopRestAmount.totalSeconds * (selectedRoundAmount - 1)
    }
    
    private func setViewTempTotalLoopState() -> String {
        var ret: String = "Exercise: \(timerLoopList.filter {$0.type == .movement}.count)"
        
        if timerLoopList.filter {$0.type == .rest}.count > 0 {
            ret += " Rest: \(timerLoopList.filter {$0.type == .rest}.count)"
        }
        
        return ret
    }
}
