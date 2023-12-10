//
//  WodViewModel+View.swift
//  Timer
//
//  Created by lkh on 11/30/23.
//

import SwiftUI
import Foundation

// MARK: - SimpleViewModel+View
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
        guard let currentRoundIdx = simpleRoundIdx,
              currentRoundIdx < simpleRounds.count else {
            return "END"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return "Movement"
        case .movement:
            return currentRoundIdx != simpleRounds.count - 1 ? "Rest" : "Rest X"
        case .rest:
            return "Movement"
        default:
            return "END"
        }
    }
    
    // MARK: - nextTimerTime
    var nextTimerTime: String {
        guard let currentRoundIdx = simpleRoundIdx,
              currentRoundIdx < simpleRounds.count else {
            return "00:00"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return simpleRounds[currentRoundIdx].movement.asTimestamp
        case .movement:
            if simpleRounds[currentRoundIdx].rest > 0 {
                return simpleRounds[currentRoundIdx].rest.asTimestamp
            } else {
                return "END"
            }
        case .rest:
            if currentRoundIdx + 1 < simpleRounds.count {
                return simpleRounds[currentRoundIdx].movement.asTimestamp
            } else {
                return "NEXT"
            }
        default:
            return "END"
        }
    }
    
    // MARK: - currentRoundDisplay
    var currentRoundDisplay: String {
        simpleRoundIdx ?? 0 < selectedRoundAmount ? "\((simpleRoundIdx ?? 0) + 1) Round" : "\(selectedRoundAmount) Round"
    }
    
    // MARK: - currentRoundString
    var currentRoundString: String {
        simpleRoundIdx ?? 0 < selectedRoundAmount ? "\((simpleRoundIdx ?? 0) + 1)" : "\(selectedRoundAmount)"
    }
    
    // MARK: - currentPhaseText
    var currentPhaseText: String {
        simpleRoundPhase?.phaseText ?? ""
    }
    
    // MARK: - currentDisplayTime
    var currentDisplayTime: String {
        simpleRoundIdx ?? 0 < selectedRoundAmount ? simpleDisplay.asTimestamp : "END"
    }
    
    // MARK: - currentRemainingString
    var currentRemainingString: String {
        "\(selectedRoundAmount - ((simpleRoundIdx ?? 0) + 1))"
    }
    
    // MARK: - currentRemainingRounds
    var currentRemainingRounds: String {
        switch simpleRoundPhase {
        case .preparation:
            return "Remaining: \(selectedRoundAmount) Round"
        default:
            return "Remaining: \(selectedRoundAmount - ((simpleRoundIdx ?? 0) + 1)) Round"
        }
    }
    
    // MARK: - isDisplayToolbarBtn
    var isDisplayToolbarBtn: Bool {
        simpleState == .paused || simpleRoundIdx ?? 0 == selectedRoundAmount
    }
    
    var isEnd: Color {
        simpleRoundIdx ?? 0 < simpleRounds.count ? Color(.black).opacity(0.3) : phaseBackgroundColor
    }
    
    /*==================================================================================*/
    // MARK: - Methods
    // ..
    // MARK: - displaySetValue
    func displaySimpleSetValue(_ state: String) -> String {
        switch state {
        case "Round":
            return String(selectedRoundAmount)
        case "Preparation":
            return String(format: "00:%02d", selectedPreparationAmount)
        case "Movements":
            if selectedMovementAmount.hours > 0 {
                return String(format: "%02d:%02d:%02d",
                              selectedMovementAmount.hours,
                              selectedMovementAmount.minutes,
                              selectedMovementAmount.seconds)
            } else {
                return String(format: "%02d:%02d", selectedMovementAmount.minutes, selectedMovementAmount.seconds)
            }
        case "Rest":
            return String(format: "%02d:%02d", selectedRestAmount.minutes,selectedRestAmount.seconds)
        default:
            return ""
        }
    }
            
    // MARK: - updateBackgroundColor
    func updateBackgroundColor() {
        guard let phase = simpleRoundPhase else { return }
        
        switch phase {
        case .preparation:
            phaseBackgroundColor = Color.randomPreparationColor()
        case .movement:
            phaseBackgroundColor = Color.randomMovementColor()
        case .rest:
            phaseBackgroundColor = Color.randomRestColor()
        case .completed:
            phaseBackgroundColor = Color(.systemGray)
        }
    }
    
    // MARK: - speakingProcessingRound
    func speakingProcessingRound() {
        DispatchQueue.global().async {
            AVManager.shared.playSound(named: self.currentRoundString, fileExtension: "caf")
            AVManager.shared.playSound(named: "round", fileExtension: "caf")
        }
        return
    }
    
    // MARK: - speakingRemainingRound
    func speakingRemainingRound() {
        DispatchQueue.global().async {
            AVManager.shared.playSound(named: self.currentRemainingString, fileExtension: "caf")
            AVManager.shared.playSound(named: "round", fileExtension: "caf")
        }
        return
    }
}
