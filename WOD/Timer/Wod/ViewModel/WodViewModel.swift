//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI
import Combine

// MARK: - WodViewModel
class WodViewModel: InputManager {
    static let shared = WodViewModel()
    @Published var isSimpleStart: Bool = false
    @Published var isDetailStart: Bool = false
    
    let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    // MARK: - displaySetValue
    func displaySetValue(_ state: String) -> String {
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
            return String(format: "00:%02d", selectedRestAmount)
        default:
            return ""
        }
    }
    
    // MARK: - simpleStartButtonTouchd
    func simpleStartButtonTouchd() {
        SimpleTimerManager.shared.roundCount = self.selectedRoundAmount
        SimpleTimerManager.shared.preparationTime = MovementTime(minutes: self.selectedPreparationAmount)
        SimpleTimerManager.shared.movementTime = MovementTime(
            hours: self.selectedMovementAmount.hours,
            minutes: self.selectedMovementAmount.minutes,
            seconds: self.selectedMovementAmount.seconds)
        SimpleTimerManager.shared.restTime = MovementTime(minutes: self.selectedRestAmount)
    }
}
