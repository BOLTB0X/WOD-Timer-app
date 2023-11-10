//
//  SimpleModel.swift
//  Timer
//
//  Created by lkh on 10/28/23.
//

import Foundation

enum SimpleButton {
    case round
    case preparation
    case movements
    case rest

    var buttonText: String {
        switch self {
        case .round: 
            return "Round"
        case .preparation: 
            return "Preparation"
        case .movements: 
            return "Movements"
        case .rest: 
            return "Rest"
        }
    }
}

struct SimpleModel {
    var roundInput: Int
    var workMinInput: Int
    var workSecInput: Int
    var restMinInput: Int
    var restSecInput: Int
    
    init() {
        roundInput = 3
        workMinInput = 0
        workSecInput = 30
        restMinInput = 0
        restSecInput = 10
    }

}
