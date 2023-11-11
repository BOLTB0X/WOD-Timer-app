//
//  InputManager.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import Foundation

struct MovementTime: Identifiable {
    let id = UUID()
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(hours: Int) {
        self.hours = hours
        self.minutes = 0
        self.seconds = 0
    }
    
    init(minutes: Int) {
        self.hours = 0
        self.minutes = minutes
        self.seconds = 0
    }
    
    init(seconds: Int) {
        self.hours = 0
        self.minutes = 0
        self.seconds = seconds
    }
    
    init(minutes: Int, seconds: Int) {
        self.hours = 0
        self.minutes = minutes
        self.seconds = seconds
    }
        
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

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
