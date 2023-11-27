//
//  WodViewModel+SimpleTimer.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import Foundation

// MARK: - Simple Timer
extension WodViewModel {
    // MARK: - simpleStartTouched
    func simpleStartTouched() {
        simpleRounds = Array(repeating: Round(preparationTime: MovementTime(seconds: selectedPreparationAmount),
                                              movementTime: selectedMovementAmount,
                                              restTime: selectedRestAmount), count: selectedRoundAmount)
        simpleTotalTime = simpleRounds.reduce(0) { $0 + $1.totalTime }
    }
}
