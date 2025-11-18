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
    
    var onTick: (() -> Void)?
    var onPhaseCompleted: (() -> Void)?
    
    var onCancelled: (() -> Void)?
    var onCompleted: (() -> Void)?
    var onActive: (() -> Void)?
    var onPaused: (() -> Void)?
    var onResumed: (() -> Void)?
    
    // MARK: - onTickImpl
    func onTickImpl() {
        guard let phase = phase else { return }
        
        // 준비 단계: countdown
        if phase == .preparation {
            display -= 1
            
            // play sound handled by Base.playSoundIfNeeded
            if display < 0 {
                onPhaseCompleted?()
                stopTicking()
                return
            }
            
        } else {
            // 증가
            display += 1
            totalTime += 1
        }
        
        // 사운드 트리거
        playSoundIfNeeded()
    } // onTickImpl
    
    
} // SimpleStopwatchEngine
