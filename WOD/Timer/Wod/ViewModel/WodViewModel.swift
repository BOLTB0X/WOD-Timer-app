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
    
    var simpleTimerManager: SimpleTimerManager = SimpleTimerManager.shared
    
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
            return String(format: "%02d:%02d", selectedRestAmount.minutes,selectedRestAmount.seconds)
        default:
            return ""
        }
    }
    
    // MARK: - simpleStartButtonTouched
    func simpleStartButtonTouched() {
//         let round = Round(
//             preparationTime: MovementTime(seconds: selectedPreparationAmount),
//             movementTime: selectedMovementAmount,
//             restTime: MovementTime(seconds: selectedRestAmount)
//         )
//         
//         // 라운드 배열로 타이머 매니저에 전달
//         let rounds = Array(repeating: round, count: selectedRoundAmount)
//        
//         simpleTimerManager = SimpleTimerManager(rounds: rounds)
    }
}
