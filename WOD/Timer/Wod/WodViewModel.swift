//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import Foundation

// MARK: - WodViewModel
class WodViewModel: InputManager {
    @Published var isSimpleStart: Bool = false
    
    
    
    func displaySetValue(_ state: String)  -> String {
        switch state {
        case "Round":
            return "\(selectedRoundAmount)"
        case "Preparation":
            return "00:\(selectedPreparationAmount)"
        case "Movements":
            return "\(selectedMovementAmount.hours):\(selectedMovementAmount.minutes):\(selectedMovementAmount.seconds)"
        case "Rest":
            return "00:\(selectedRestAmount)"
        default:
            return ""
        }
    }
}
