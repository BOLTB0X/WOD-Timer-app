//
//  WodViewModel+View.swift
//  Timer
//
//  Created by lkh on 11/30/23.
//

import SwiftUI
import Foundation

// MARK: - WodViewModel+View
extension WodViewModel {
    // MARK: - 염산 프로퍼티s
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
            return "Next: End"
        }
        
        switch simpleRoundPhase {
        case .preparation:
            return "Next: Movement"
        case .movement:
            return "Next: Rest"
        case .rest:
            return "Next: movement"
        default:
            return ""
        }
    }
    
    // MARK: - nextTimerTime
    var nextTimerTime: String {
        guard let currentRoundIdx = simpleRoundIdx,
              currentRoundIdx < simpleRounds.count else {
            return "END"
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
                return "END"
            }
        default:
            return "END"
        }
    }
    
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
            phaseBackgroundColor = .clear
        }
    }
}
