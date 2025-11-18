//
//  SimpleTimerEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Foundation
import Combine

// MARK: - SimpleTimerEngine
final class SimpleTimerEngine: BaseTimerEngine {
    var cancellable: AnyCancellable?
    var display: Int = 0
    var totalTime: Int = 0
    var phase: SimpleRoundPhase?
    
    var onTick: (() -> Void)?
    var onPhaseCompleted: (() -> Void)?
    
    // PhaseStateHandler
    var onCancelled: (() -> Void)?
    var onCompleted: (() -> Void)?
    var onActive: (() -> Void)?
    var onPaused: (() -> Void)?
    var onResumed: (() -> Void)?
    
    // MARK: - onTickImpl
    func onTickImpl() {
        guard let phase = phase else { return }
        
        //preparation이 아니면 totalTime 감소
        if display > 0 && phase != .preparation {
            totalTime -= 1
        }
        
        display -= 1
        
        // 사운드/기타 트리거
        playSoundIfNeeded()
        
        // phase 종료 판단 (원래: if display < 0 then completed)
        if display < 0 {
            onPhaseCompleted?()
            stopTicking()
        }
    } // onTickImpl
    
} // SimpleTimerEngine
