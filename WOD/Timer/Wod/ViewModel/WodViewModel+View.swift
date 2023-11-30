//
//  WodViewModel+View.swift
//  Timer
//
//  Created by lkh on 11/30/23.
//

import Foundation

// MARK: - WodViewModel+View
extension WodViewModel {
    // MARK: - confirmationMessage
    var confirmationMessage: String {
        return """
            Are you sure you want to start?
            Total Round: \(selectedRoundAmount)
            Select Preparation: \(selectedPreparationAmount)
            Select Movement: \(String(format: "%02d:%02d:%02d", selectedMovementAmount.hours, selectedMovementAmount.minutes, selectedMovementAmount.seconds))
            Select Rest: \(selectedRestAmount.totalSeconds)
            Total Second: \(selectedRoundAmount * (selectedPreparationAmount+selectedMovementAmount.hours + selectedMovementAmount.minutes + selectedMovementAmount.seconds + selectedRestAmount.totalSeconds) - selectedRestAmount.totalSeconds)
            """
    }
    
    // MARK: - displaySetValue
    func displaySimpleSetValue(_ state: String) -> String {
        switch state {
        case "Round":
            return String(selectedRoundAmount)
        case "Preparation":
            return String(format: "00:%02d", selectedPreparationAmount)
        case "Movements":
            return String(format: "%02d:%02d:%02d",
                          selectedMovementAmount.hours,
                          selectedMovementAmount.minutes,
                          selectedMovementAmount.seconds)
        case "Rest":
            return String(format: "%02d:%02d", selectedRestAmount.minutes,selectedRestAmount.seconds)
        default:
            return ""
        }
    }
    
}
