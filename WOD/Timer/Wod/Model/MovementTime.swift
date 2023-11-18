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
        MovementTime(totalSeconds: lhs.totalSeconds + rhs.totalSeconds)
    }

    var totalSeconds: Int {
        hours * 3600 + minutes * 60 + seconds
    }
    
    init(totalSeconds: Int) {
        self.hours = totalSeconds / 3600
        self.minutes = (totalSeconds % 3600) / 60
        self.seconds = totalSeconds % 60
    }
}
