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
    
    @Published var simpleRounds: [Round]
    var simpleTotalTime:Int = 0
    var timerCancellable: AnyCancellable?
    
    let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    private override init() {
        simpleRounds = []
        timerCancellable = nil
    }
    
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
}
