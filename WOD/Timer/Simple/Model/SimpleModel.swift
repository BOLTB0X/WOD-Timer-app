//
//  MovementTime.swift
//  Timer
//
//  Created by lkh on 11/17/23.
//

import Foundation

// MARK: - StartComplted
struct StartComplted {
    var movementStart: String
    var restStart: String
    var movementComplted: String
    var restComplted: String
    
    init() {
        self.movementStart = ""
        self.restStart = ""
        self.movementComplted = ""
        self.restComplted = ""
    }
    
    init(movementStart: String, restStart: String, movementComplted: String, restComplted: String) {
        self.movementStart = movementStart
        self.restStart = restStart
        self.movementComplted = movementComplted
        self.restComplted = restComplted
    }
}


// MARK: - TmRound
// 타이머
struct TmRound: Identifiable, Equatable {
    let id = UUID()
    var movement: Int
    var rest: Int
    var date: StartComplted
    
    init() {
        self.movement = 0
        self.rest = 0
        self.date = StartComplted()
    }
    
    init(movement: Int, rest: Int, date: StartComplted) {
        self.movement = movement
        self.rest = rest
        self.date = date
    }
    
    static func == (lhs: TmRound, rhs: TmRound) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - SwRound
// 스톱워치
struct SwRound: Identifiable, Equatable {
    let id = UUID()
    var movement: Int
    var rest: Int
    var date: StartComplted
    
    init() {
        self.movement = 0
        self.rest = 0
        self.date = StartComplted()
    }
    
    init(movement: Int, rest: Int, date: StartComplted) {
        self.movement = movement
        self.rest = rest
        self.date = date
    }
    
    static func == (lhs: SwRound, rhs: SwRound) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - RoundHistory
// 타이머 스톱워치 기록
struct RoundHistory {
    var pauseHistory: [RecordHistory?]
    var restartHistory: [RecordHistory?]
    var moveLeftHistory: [RecordHistory?]
    var moveRightHistory: [RecordHistory?]
    
    init() {
        self.pauseHistory = []
        self.restartHistory = []
        self.moveLeftHistory = []
        self.moveRightHistory = []
    }
    
    init(pauseHistory: [RecordHistory?], restartHistory: [RecordHistory?], moveLeftHistory: [RecordHistory?], moveRightHistory: [RecordHistory?]) {
        self.pauseHistory = pauseHistory
        self.restartHistory = restartHistory
        self.moveLeftHistory = moveLeftHistory
        self.moveRightHistory = moveRightHistory
    }
}
