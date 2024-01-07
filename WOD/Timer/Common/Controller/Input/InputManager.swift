//
//  InputManager.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import Foundation

// MARK: - InputManager
class InputManager: ObservableObject {
    // MARK: - Common
    // ...
    // MARK: - timer
    @Published var selectedRoundAmount = 3
    @Published var selectedPreparationAmount = 5
    @Published var selectedMovementAmount = MovementTime(hours: 0, minutes: 0, seconds: 30)
    @Published var selectedRestAmount = MovementTime(hours: 0, minutes: 0, seconds: 10)
    
    // MARK: - stopwatch
    @Published var selectedRoundStop = 3
    @Published var selectedPreparationStop = 5
    
    // MARK: - etc
    @Published var isCalculatedBtn: Bool = false
    
    // MARK: - Common property
    let roundRange = Array(1...20)
    let preparationRange = Array(1...59)
    let hoursRange = Array(0...99)
    let minutesRange = Array(0...59)
    let secondsRange = Array(1...59)
    
    // ...
    
    // MARK: - Detail
    @Published var movementText: String = ""
    @Published var selectedLoopRestAmount = MovementTime(hours: 0, minutes: 0, seconds: 10)
    @Published var isSelectedColor: Int = 0
}
