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
} // EngineMode

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
    func internalTick()
} // BaseTimerEngine

// MARK: - default methods
extension BaseTimerEngine {
    
    // MARK: - startTicking
    func startTicking() {
        stopTicking()
        
        var isFirstTick = true
        
        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if isFirstTick {
                    isFirstTick = false
                    return
                }
                
                self.internalTick()
                self.onTick?()
            } // sink
        
    } // startTicking
    
    // MARK: - stopTicking
    func stopTicking() {
        cancellable?.cancel()
        cancellable = nil
    } // stopTicking
    
    // MARK: - pauseTicking
    func pauseTicking() {
        stopTicking()
    } // pauseTicking
    
    // MARK: - resumeTicking
    func resumeTicking() {
        startTicking()
    } // resumeTicking
    
    // MARK: - playSoundIfNeeded
    func playSoundIfNeeded() {
        if display <= 5 && display > 0 {
            AVManager.shared.playSoundSync(named: "whistle_counting", fileExtension: "caf")
        } else if display == 0 {
            AVManager.shared.playSoundSync(named: "whistle_countComplete", fileExtension: "caf")
        }
    } // playSoundIfNeeded
    
} // default methods
