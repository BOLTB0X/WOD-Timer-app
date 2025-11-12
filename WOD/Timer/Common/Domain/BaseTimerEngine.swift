//
//  BaseTimerEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Foundation

// MARK: - BaseTimerEngine
protocol BaseTimerEngine: AnyObject, PhaseStateHandler {
    var cancellable: AnyCancellable? { get set }
    var display: Int { get set }
    var totalTime: Int { get set }
    var phase: SimpleRoundPhase? { get set }

    func startTicking()
    func stopTicking()
    func onTick()
    func onPhaseCompleted()

} // BaseTimerEngine

extension BaseTimerEngine {
    
    
    // MARK: - startTicking
    func startTicking() {
        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.onTick()
            }
    } // startTicking

    // MARK: - stopTicking
    func stopTicking() {
        cancellable?.cancel()
    } // stopTicking

    // MARK: - playSoundIfNeeded
    func playSoundIfNeeded() {
        if display <= 5 && display > 0 {
            AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
        } else if display == 0 {
            AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
        }
    } // playSoundIfNeeded
    
    
} // BaseTimerEngine
