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
        self.color = 2
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
    var cycleRest: MovementTime
    var date: StartComplted
    
    // MARK: init
    init() {
        self.movement = [DetailItem(type: .movement)]
        self.cycleRest = MovementTime(seconds: 10)
        self.date = StartComplted()
    }
    
    init(movement: [DetailItem], cycleRest: MovementTime, date: StartComplted) {
        self.movement = movement
        self.cycleRest = cycleRest
        self.date = date
    }
    
    static func == (lhs: DetailRound, rhs: DetailRound) -> Bool {
        return lhs.id == rhs.id
    }
}
