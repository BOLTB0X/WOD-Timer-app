//
//  BaseTimerEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Combine
import Foundation

// MARK: - EngineMode
enum EngineMode {
    case timer
    case stopwatch
}

// MARK: - BaseTimerEngine
protocol BaseTimerEngine: AnyObject {
    var cancellable: AnyCancellable? { get set }
    var display: Int { get set }
    var totalTime: Int { get set }
    var phase: SimpleRoundPhase? { get set }
    var currentRoundIndex: Int? { get set }
    var rounds: [SimpleRound] { get set }
    var mode: EngineMode { get set }

    // callbacks to consumer (ViewModel)
    var onTick: (() -> Void)? { get set }
    var onPhaseCompleted: (() -> Void)? { get set }

    func startTicking()
    func pauseTicking()
    func resumeTicking()
    func stopTicking()
    func advancePhase()
} // BaseTimerEngine

extension BaseTimerEngine {
    // default timer using Combine.Timer
    func startTicking() {
        stopTicking()
        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.internalTick()
                self.onTick?()
            }
    }
    func stopTicking() {
        cancellable?.cancel()
        cancellable = nil
    }
    func pauseTicking() {
        stopTicking()
    }
    func resumeTicking() {
        startTicking()
    }

    // MARK: - playSoundIfNeeded
    func playSoundIfNeeded() {
        if display <= 5 && display > 0 {
            AVManager.shared.playSoundSync(named: "whistle_counting", fileExtension: "caf")
        } else if display == 0 {
            AVManager.shared.playSoundSync(named: "whistle_countComplete", fileExtension: "caf")
        }
    } // playSoundIfNeeded

    // MARK: - internalTick
    // impl 대체
    func internalTick() {
        // default no-op: implement in concrete engine
    }
}
