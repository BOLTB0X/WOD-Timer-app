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
    // MARK: - 프로퍼티
    static let shared = WodViewModel()
    
    @Published var isSimpleStart: Bool = false
    @Published var isDetailStart: Bool = false
    
    @Published var simpleRounds: [Round]
    var simpleTotalTime:Int = 0
    
    @Published var timerMonitor: TimerMonitor?
    @Published var currentRoundIndex: Int = 0
    @Published var timerState: TimerState = .cancelled
    @Published var currentSimpleRoundPhase: SimpleRoundPhase = .preparation

    let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    // 타이머 메모리 날리기 용
    var cancellables: Set<AnyCancellable> = []
    
    
    override init() {
        simpleRounds = []
    }
}
