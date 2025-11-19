//
//  PhaseEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/19/25.
//

import Foundation
import Combine

// MARK: - PhaseEngine
final class PhaseEngine: BaseTimerEngine, PhaseStateHandler {
    var cancellable: AnyCancellable?
    var display: Int = 0
    var totalTime: Int = 0
    var phase: SimpleRoundPhase?
    var currentRoundIndex: Int?
    var rounds: [SimpleRound] = []
    var mode: EngineMode = .timer

    var onTick: (() -> Void)?
    var onPhaseCompleted: (() -> Void)?

    // PhaseStateHandler callbacks
    var onCancelled: (() -> Void)?
    var onCompleted: (() -> Void)?
    var onActive: (() -> Void)?
    var onPaused: (() -> Void)?
    var onResumed: (() -> Void)?

    init(mode: EngineMode = .timer) {
        self.mode = mode
    } // init

    // MARK: - internalTick
    func internalTick() {
        guard let phase = phase else { return }

        switch mode {
        case .timer:
            // countdown behavior: if not preparation, decrement totalTime too
            if display > 0 && phase != .preparation {
                totalTime -= 1
            }
            display -= 1
            playSoundIfNeeded()
            if display < 0 {
                // phase finished
                onPhaseCompleted?()
                stopTicking()
            }

        case .stopwatch:
            // preparation counts down; others count up
            if phase == .preparation {
                display -= 1
                playSoundIfNeeded()
                if display < 0 {
                    onPhaseCompleted?()
                    stopTicking()
                }
            } else {
                display += 1
                totalTime += 1
                playSoundIfNeeded()
            }
        }
    } // internalTick

    // MARK: - advancePhase
    func advancePhase() {
        guard let idx = currentRoundIndex,
                idx < rounds.count,
              let currentPhase = phase
        else { return }
        
        let isLastRound = (idx == rounds.count - 1)
        let nextPhase = currentPhase.next(isLastRound: isLastRound)

        switch nextPhase {
        case .preparation:
            phase = .preparation
            display = rounds[idx].movement
            onActive?()
        case .movement:
            phase = .movement
            display = rounds[idx].movement
            onActive?()
        case .rest:
            phase = .rest
            display = rounds[idx].rest
            onActive?()
        case .completed:
            // move to next round or finish
            moveToNextRoundOrFinish()
        }
    } // advancePhase

    // MARK: - moveToNextRoundOrFinish
    private func moveToNextRoundOrFinish() {
        // increment index
        if currentRoundIndex == nil {
            currentRoundIndex = 0
        } else {
            currentRoundIndex! += 1
        }
        // if overflow -> finished
        guard let idx = currentRoundIndex, idx < rounds.count else {
            phase = .completed
            totalTime = 0
            display = 0
            onCompleted?()
            return
        }
        // set to preparation for next round by default
        phase = .preparation
        display = rounds[idx].movement // VM should set actual selectedPreparationAmount if needed
        onActive?()
    } // moveToNextRoundOrFinish

    // configure
    func configure(rounds: [SimpleRound], roundIndex: Int, initialPhase: SimpleRoundPhase, displaySeconds: Int, totalTime: Int, mode: EngineMode) {
        self.rounds = rounds
        self.currentRoundIndex = roundIndex
        self.phase = initialPhase
        self.display = displaySeconds
        self.totalTime = totalTime
        self.mode = mode
    } // configure

    // control methods (start/pause/resume/cancel)
    // ...
    
    func start() {
        onActive?()
        startTicking()
    } // start
    
    func pause() {
        onPaused?()
        pauseTicking()
    } // pause
    
    func resume() {
        onResumed?()
        resumeTicking()
    } // resume
    
    func cancel() {
        onCancelled?()
        stopTicking()
        phase = .completed
        display = 0
    } // cancel
} // PhaseEngine
