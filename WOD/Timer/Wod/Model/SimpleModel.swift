//
//  SimpleModel.swift
//  Timer
//
//  Created by lkh on 10/28/23.
//

import Foundation

struct SimpleModel {
    var roundInput: Int
    var workMinInput: Int
    var workSecInput: Int
    var restMinInput: Int
    var restSecInput: Int
    
    init() {
        self.roundInput = 3
        self.workMinInput = 0
        self.workSecInput = 30
        self.restMinInput = 0
        self.restSecInput = 10
    }

}
