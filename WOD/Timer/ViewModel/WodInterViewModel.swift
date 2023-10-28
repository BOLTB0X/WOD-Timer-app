//
//  WodInterViewModel.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import Foundation

class WodInterViewModel: ObservableObject {
    @Published var inputSimple: SimpleModel = SimpleModel() 
    
    
    private var settingTime: Double = 0.00
    private var settingRound: Int = 0
    
    func incrementRound() {
        inputSimple.roundInput += 1
    }
}
