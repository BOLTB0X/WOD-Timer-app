//
//  DetailModel.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailItem
struct DetailItem: Identifiable, Equatable {
    let id = UUID()
    let type: DetailItemType
    var title: String
    var time: MovementTime
    var color: Int
    
    // MARK: init
    init(type: DetailItemType) {
        self.type = type
        self.title = ""
        self.time = MovementTime(seconds: type == .movement ? 30 : 10)
        self.color = 2
    }
    
    init(type: DetailItemType, title: String) {
        self.type = type
        self.title = title
        self.time = MovementTime(seconds: type == .movement ? 30 : 10)
        self.color = type == .movement ? 2 : 5
    }
    
    init(type: DetailItemType, title: String, time: MovementTime) {
        self.type = type
        self.title = title
        self.time = time
        self.color = 2
    }
    
    init(type: DetailItemType, title: String, time: MovementTime, color: Int) {
        self.type = type
        self.title = title
        self.time = time
        self.color = color
    }
    
    static func == (lhs: DetailItem, rhs: DetailItem) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - SimpleRound
// 타이머, 스톱워치
struct DetailRound: Identifiable, Equatable {
    let id = UUID()
    var movement: [DetailItem]
    var roundRest: Int
    var date: StartComplted
    
    // MARK: init
    init() {
        self.movement = [DetailItem(type: .movement)]
        self.roundRest = 0
        self.date = StartComplted()
    }
    
    init(movement: [DetailItem], loopRest: Int, date: StartComplted) {
        self.movement = movement
        self.roundRest = loopRest
        self.date = date
    }
    
    // MARK: totalMovementTime
    var totalMovementTime: Int {
        let totalSeconds = movement.reduce(0) { $0 + $1.time.totalSeconds }
        return totalSeconds
    }
    
    static func == (lhs: DetailRound, rhs: DetailRound) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - SimpleRound
// 타이머
struct DetailTmRound: Identifiable, Equatable {
    let id = UUID()
    let currentRound: Int
    let currentPhase: DetailRoundPhase
    let currentLoop: Int?
    let lengthLoop: Int?
    let title: String?
    var time: MovementTime
    let color: Int?
    var startDate: String
    var history: [String]
    var endDate: String
    
    // 준비, 휴식 용 init
    init(currentRound: Int, currentPhase: DetailRoundPhase, currentLoop: Int? = nil, lengthLoop: Int? = nil, title: String, time: MovementTime, color: Int? = nil) {
        self.currentRound = currentRound
        self.currentPhase = currentPhase
        self.currentLoop = nil
        self.lengthLoop = nil
        self.title = title
        self.time = time
        self.color = nil
        self.startDate = ""
        self.history = []
        self.endDate = ""
    }
    
    // 사이클 용 init
    init(currentRound: Int, currentPhase: DetailRoundPhase, currentLoop: Int, lengthLoop: Int ,title: String, time: MovementTime, color: Int) {
        self.currentRound = currentRound
        self.currentPhase = currentPhase
        self.currentLoop = currentLoop
        self.lengthLoop = lengthLoop
        self.title = title
        self.time = time
        self.color = color
        self.startDate = ""
        self.history = []
        self.endDate = ""
    }

    static func == (lhs: DetailTmRound, rhs: DetailTmRound) -> Bool {
        return lhs.id == rhs.id
    }
}
