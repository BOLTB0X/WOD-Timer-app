//
//  Movements.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import Foundation

struct Movements: Identifiable {
    let id = UUID()
    let name: String
    var detail: String
    var limitTime: String // Aim
    var endTime: String
    var startTime: String
    var isRunning: Bool
    
    init() {
        self.name = ""
        self.detail = ""
        self.limitTime = ""
        self.endTime = ""
        self.startTime = ""
        self.isRunning = false
    }
    
    init(name: String, detail: String , limitTime: String, endTime: String, startTime: String, isRunning: Bool) {
        self.name = name
        self.detail = detail
        self.limitTime = limitTime
        self.endTime = endTime
        self.startTime = startTime
        self.isRunning = isRunning
    }
    
    static func getDummy() -> Movements {
        Movements(name: "push-Up", detail: "2", limitTime: "30", endTime: "", startTime: "", isRunning: false)
    }
}

struct InputMovements {
    var name: String
    var detail: String
    var aim: String
}
