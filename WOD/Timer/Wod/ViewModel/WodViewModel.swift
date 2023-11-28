//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI
import Combine

// MARK: - WodViewModel
class WodViewModel: InputManager {
    static let shared = WodViewModel()
    @Published var isSimpleStart: Bool = false
    @Published var isDetailStart: Bool = false
    
    @Published var simpleRounds: [Round]
    var simpleTotalTime:Int = 0
    
    @Published var timerMonitor: TimerMonitor?
    @Published var currentRoundIndex: Int = 0
    
    let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    var cancellables: Set<AnyCancellable> = []
    
    override init() {
        simpleRounds = []
    }
}
