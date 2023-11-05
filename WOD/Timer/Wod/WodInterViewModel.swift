//
//  WodInterViewModel.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import Foundation

class WodInterViewModel: ObservableObject {
    @Published var inputSimple: SimpleModel = SimpleModel()
    @Published var selectedHoursAmount = 10
    @Published var selectedMinutesAmount = 10
    @Published var selectedSecondsAmount = 10
    @Published var isCalculatedBtn: Bool = false
    
    private var settingTime: Double = 0.00
    private var settingRound: Int = 0
    
    let hoursRange = Array(0...99)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)
    
    func incrementRound() {
        inputSimple.roundInput += 1
    }
}
