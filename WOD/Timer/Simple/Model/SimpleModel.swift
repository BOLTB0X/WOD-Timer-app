//
//  MovementTime.swift
//  Timer
//
//  Created by lkh on 11/17/23.
//

import Foundation

// MARK: - MovementTime
// 타이머 카운트다운 할 때 쓸 모델
struct MovementTime {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    // MARK: init
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
    
    // 연산자 오버로딩
    static func + (lhs: MovementTime, rhs: MovementTime) -> MovementTime {
        let totalSeconds = lhs.totalSeconds + rhs.totalSeconds
        return MovementTime(totalSeconds: totalSeconds)
    }
    
    // MARK: 연산 프로퍼티s
    var totalSeconds: Int {
        hours * 3600 + minutes * 60 + seconds
    }
    
    var timerBigFontSize: CGFloat {
        return hours > 0 ? 85 : 120
    }
    
    var timerSmallFontSize: CGFloat {
        return hours > 0 ? 50 : 60
    }
    
    init(totalSeconds: Int) {
        self.hours = totalSeconds / 3600
        self.minutes = (totalSeconds % 3600) / 60
        self.seconds = totalSeconds % 60
    }
    
    
    init(totalSeconds: Double) {
        self.init(seconds: Int(totalSeconds))
    }
}

// MARK: - Round
struct Round {
    var preparationTime: MovementTime
    var movementTime: MovementTime
    var restTime: MovementTime
    
    var elapsedPreparationTime: MovementTime = MovementTime(seconds: 0)
    var elapsedMovementTime: MovementTime = MovementTime(seconds: 0)
    var elapsedRestTime: MovementTime = MovementTime(seconds: 0)
    
    var totalTime: Int {
        preparationTime.totalSeconds + movementTime.totalSeconds + restTime.totalSeconds
    }
}
