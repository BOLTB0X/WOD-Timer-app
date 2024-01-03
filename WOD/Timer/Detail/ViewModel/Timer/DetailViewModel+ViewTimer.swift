//
//  DetailViewModel+ViewTimer.swift
//  Timer
//
//  Created by lkh on 1/3/24.
//

import Foundation

// MARK: - DetailViewModel+View Timer
// 뷰에 나타내는 텍스트, 컬러 관련 연산 프로퍼티 및 메소드들
extension DetailViewModel {
    // MARK: - 연산 프로퍼티s
    // ..
    // MARK: - confirmationMessage
    var confirmationMessage: String {
        return """
            Are you sure you want to start?
            Total Round: \(selectedRoundAmount)
            Select Preparation: \(selectedPreparationAmount)
            Select Movement: \(timerLoopList.count)
            Select Rest: \(selectedRestAmount.totalSeconds)
            Total Second: \(detailTotalTime)
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
}
