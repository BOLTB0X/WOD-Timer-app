//
//  SimpleTimerEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Foundation

// MARK: - SimpleTimerEngine
final class SimpleTimerEngine: BaseTimerEngine {
    var cancellable: AnyCancellable?
    var display: Int = 0
    var totalTime: Int = 0
    var phase: SimpleRoundPhase?

    var onCancelled: (() -> Void)?
    var onCompleted: (() -> Void)?
    var onActive: (() -> Void)?
    var onPaused: (() -> Void)?
    var onResumed: (() -> Void)?

    // MARK: - onTick
    func onTick() {
        guard let phase else { return }

        if display > 0 && phase != .preparation {
            totalTime -= 1
        }
        display -= 1

        playSoundIfNeeded()

        if display < 0 {
            onPhaseCompleted()
        }
    } // onTick

    // MARK: - onPhaseCompleted
    func onPhaseCompleted() {
        onCompleted?()
        stopTicking()
    } // onPhaseCompleted
    
} // SimpleTimerEngine
