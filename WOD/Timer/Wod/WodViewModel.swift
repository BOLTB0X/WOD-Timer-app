//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import Foundation

// MARK: - WodViewModel
class WodViewModel: InputManager {
    
    func displaySetValue(_ state: String)  -> String {
        switch state {
        case "Round":
            return "\(selectedRoundAmount)"
        case "Preparation":
            return "\(selectedPreparationAmount)"
        case "Movements":
            return "\(selectedMovementAmount.hours):\(selectedMovementAmount.minutes):\(selectedMovementAmount.seconds)"
        case "Rest":
            return "\(selectedRestAmount)"
        default:
            return ""
        }
    }
}
