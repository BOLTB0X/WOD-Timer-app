//
//  TimerProtocol.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Foundation
import Combine

// MARK: - TimerProtocol
protocol TimerProtocol: ObservableObject, PhaseStateHandler {
    var totalDuration: Int { get set }
    var currentTime: Int { get set }
    var timerState: TimerState { get set }
    var timerCancellable: AnyCancellable? { get set }

    func startTimer()
    func pauseTimer()
    func resumeTimer()
    func cancelTimer()
    func completeTimer()
    
} // TimerProtocol
