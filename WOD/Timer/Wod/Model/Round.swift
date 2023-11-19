//
//  Round.swift
//  Timer
//
//  Created by lkh on 11/19/23.
//

import Foundation

struct Round {
    var preparationTime: MovementTime
    var movementTime: MovementTime
    var restTime: MovementTime
    
    var totalTime: MovementTime {
        preparationTime + movementTime + restTime
    }
}
