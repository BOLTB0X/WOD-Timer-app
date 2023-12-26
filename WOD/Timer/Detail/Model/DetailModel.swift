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
    var title: String
    var time: Int
    var color: String
    
    init() {
        self.title = ""
        self.time = 0
        self.color = "lightBlue1"
    }
    
    init(title: String) {
        self.title = title
        self.time = 30
        self.color = "lightBlue1"
    }
    
    init(title: String, time: Int) {
        self.title = title
        self.time = time
        self.color = "lightBlue1"
    }
    
    init(title: String, time: Int, color: String) {
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
    var rest: [DetailItem]
    var cycleRest: DetailItem
    var date: StartComplted
    
    init() {
        self.movement = [DetailItem()]
        self.rest = [DetailItem()]
        self.cycleRest = DetailItem()
        self.date = StartComplted()
    }
    
    init(movement: [DetailItem], rest: [DetailItem], cycleRest: DetailItem, date: StartComplted) {
        self.movement = movement
        self.rest = rest
        self.cycleRest = cycleRest
        self.date = date
    }
    
    static func == (lhs: DetailRound, rhs: DetailRound) -> Bool {
        return lhs.id == rhs.id
    }
}
