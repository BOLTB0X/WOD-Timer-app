//
//  InputTime.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import Foundation

struct InputSimple {
    var roundString: String
    var readayMinString: String
    var readaySecString: String
    var workName: String
    var workMinString: String
    var workSecString: String
    var restMinString: String
    var restSecString: String
    
    init() {
        roundString = "0"
        readayMinString = "0"
        readaySecString = "3"
        workName = "work"
        workMinString = "0"
        workSecString = "30"
        restMinString = "0"
        restSecString = "5"
    }
    
    init(roundString: String, readayMibString: String, readaySecString: String, workName: String, workMinString: String, workSecString: String, restMinString: String, restSecString: String) {
        self.roundString = roundString
        self.workName = workName
        self.readayMinString = readayMibString
        self.readaySecString = readaySecString
        self.workMinString = workMinString
        self.workSecString = workSecString
        self.restMinString = restMinString
        self.restSecString = restSecString
    }
    
    func getUsingSimple() -> usingSimple {
        let simpleRound = Int(roundString) ?? 0
        let workMin = Double(workMinString) ?? 0
        let workSec = Double(workSecString) ?? 0
        let restMin = Double(restMinString) ?? 0
        let restSec = Double(restSecString) ?? 0
        
        return usingSimple(stringInput: self, simpleRound: simpleRound, wrokMin: workMin, workSec: workSec, restMin: restMin, restSec: restSec)
    }
}

struct usingSimple {
    var stringInput: InputSimple
    var simpleRound: Int
    var workName: String
    var workMin: Double
    var workSec: Double
    var restMin: Double
    var restSec: Double
    
    init () {
        stringInput = InputSimple()
        workName = "work"
        simpleRound = 3
        workMin = 0
        workSec = 0
        restMin = 0
        restSec = 0
    }
    
    init(stringInput: InputSimple, simpleRound: Int, wrokMin: Double, workSec: Double, restMin: Double, restSec: Double) {
        self.stringInput = stringInput
        self.simpleRound = simpleRound
        self.workName = "work" // 디폴트
        self.workMin = wrokMin
        self.workSec = workSec
        self.restMin = restMin
        self.restSec = restSec
    }
    
    init(stringInput: InputSimple) {
        self.stringInput = stringInput
        self.simpleRound = Int(stringInput.roundString) ?? 0
        self.workName = "work" // 디폴트
        self.workMin = Double(stringInput.workMinString) ?? 0
        self.workSec = Double(stringInput.workSecString) ?? 0
        self.restMin = Double(stringInput.restMinString) ?? 0
        self.restSec = Double(stringInput.restSecString) ?? 0
    }
    
    func totalWorkoutTime() -> Double {
        let workInSeconds = (workMin * 60) + workSec
        let restInSeconds = (restMin * 60) + restSec
        return (workInSeconds + restInSeconds) * Double(simpleRound)
    }
}
