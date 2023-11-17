//
//  InputManager.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import Foundation

// MARK: - InputManager
class InputManager: ObservableObject {
    // MARK: - Published
    @Published var selectedRoundAmount = 3
    @Published var selectedPreparationAmount = 5
    @Published var selectedMovementAmount = MovementTime(hours: 0, minutes: 0, seconds: 30)
    @Published var selectedRestAmount = 10

    @Published var isCalculatedBtn: Bool = false
    
    // MARK: - Common property
    let roundRange = Array(1...99)
    let preparationRange = Array(0...60)
    let hoursRange = Array(0...99)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)
}
