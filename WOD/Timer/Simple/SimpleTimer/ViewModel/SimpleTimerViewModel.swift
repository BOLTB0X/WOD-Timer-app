//
//  SimpleTimerViewModel.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/18/25.
//

import Foundation
import Combine

// MARK: - SimpleTimerViewModel
final class SimpleTimerViewModel: TimerProtocol {
    @Published var totalDuration: Int = 0
    @Published var currentTime: Int = 0
    @Published var timerState: TimerState = .cancelled
    var timerCancellable: AnyCancellable?

    private let engine = SimpleTimerEngine()

    var onCancelled: (() -> Void)?
    var onCompleted: (() -> Void)?
    var onActive: (() -> Void)?
    var onPaused: (() -> Void)?
    var onResumed: (() -> Void)?

    init() {
        bindEngine()
    }

    func bindEngine() {
        engine.onCompleted = { [weak self] in
            self?.completeTimer()
        }
    }

    func startTimer() { engine.startTicking() }
    func pauseTimer() { engine.stopTicking() }
    func resumeTimer() { engine.startTicking() }
    func cancelTimer() { engine.stopTicking() }
    func completeTimer() { engine.stopTicking() }
} // SimpleTimerViewModel
