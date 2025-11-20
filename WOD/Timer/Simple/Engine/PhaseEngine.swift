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

    var onCancelled: (() -> Void)?
    var onCompleted: (() -> Void)?
    var onActive: (() -> Void)?
    var onPaused: (() -> Void)?
    var onResumed: (() -> Void)?

    init(mode: EngineMode = .timer) {
        self.mode = mode
    } // init

} // PhaseEngine

// MARK: - tick methods
extension PhaseEngine {
    
    // MARK: - internalTick
    func internalTick() {
        guard let phase = phase else { return }

        switch mode {
        case .timer:
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
        case .movement:
            phase = .movement
            display = rounds[idx].movement
        case .rest:
            phase = .rest
            display = rounds[idx].rest
        case .completed:
            moveToNextRoundOrFinish()
        }
    } // advancePhase

    // MARK: - moveToNextRoundOrFinish
    private func moveToNextRoundOrFinish() {
        if currentRoundIndex == nil {
            currentRoundIndex = 0
        } else {
            currentRoundIndex! += 1
        }
        
        guard let idx = currentRoundIndex,
                idx < rounds.count
        else {
            phase = .completed
            totalTime = 0
            display = 0
            return
        }
        
        phase = .preparation
        display = rounds[idx].movement
    } // moveToNextRoundOrFinish

    // MARK: - configure
    func configure(rounds: [SimpleRound], roundIndex: Int, initialPhase: SimpleRoundPhase, displaySeconds: Int, totalTime: Int, mode: EngineMode) {
        self.rounds = rounds
        self.currentRoundIndex = roundIndex
        self.phase = initialPhase
        self.display = displaySeconds
        self.totalTime = totalTime
        self.mode = mode
    } // configure

} // tick methods

// MARK: - control methods
extension PhaseEngine {
    
    // MARK: - start
    func start() {
        onActive?()
        startTicking()
    } // start
    
    // MARK: - pause
    func pause() {
        onPaused?()
        pauseTicking()
    } // pause
    
    // MARK: - resume
    func resume() {
        onResumed?()
        resumeTicking()
    } // resume
    
    // MARK: - cancel
    func cancel() {
        onCancelled?()
        stopTicking()
        phase = .completed
        display = 0
    } // cancel
    
} // control methods
