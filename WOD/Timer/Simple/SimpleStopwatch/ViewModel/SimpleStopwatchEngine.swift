//
//  SimpleStopwatchEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Foundation
import Combine

// MARK: - SimpleStopwatchEngine
final class SimpleStopwatchEngine: BaseTimerEngine {
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

        if phase == .preparation {
            display -= 1
            if display < 0 { onPhaseCompleted() }
        } else {
            display += 1
            totalTime += 1
        }

        playSoundIfNeeded()
    } // onTick

    // MARK: - onPhaseCompleted
    func onPhaseCompleted() {
        onCompleted?()
        stopTicking()
    } // onPhaseCompleted
    
} // SimpleStopwatchEngine
