//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI
import Combine
import ActivityKit

// MARK: - SimpleViewModel
@MainActor
class SimpleViewModel: InputManager {
    
    static let shared = SimpleViewModel() // 싱글톤 패턴
    
    // MARK: - 프로퍼티s
    // ...
    // etc
    @Published var simpleCompletion: Date? // 완료일
    @Published var simpleDisplay: Int = 0
    
    // MARK: - Timer
    @Published var simpleTmRounds: [SimpleRound] = [] // 심플 타이머루틴 배열
    @Published var simpleTotalTime:Int = 0 // 심플 루틴 배열의 총 시간
    @Published var simpleTmRoundIdx: Int? //
    @Published var simpleTimerCompletion: String = "X" // 완료일
    @Published var simpleTimerHistory: RoundHistory = RoundHistory() // 히스토리
    
    // 진행률 -> 타이머
    @Published var simpleUnitProgress: Float = 0.0
    @Published var simpleFullProgress: Float = 0.0
    
    // 타이머 상태 관련
    @Published var simpleTimerState: TimerState = .cancelled {
        didSet { handleTimerState(simpleTimerState) }
    }
    // MARK: - Stopwatch
    // 심플 스톱워치 루틴 배열
    @Published var simpleSwRounds: [SimpleRound] = []  // 심플 루틴 배열
    
    @Published var simpleSwRoundIdx: Int? //
    @Published var simpleSwCompletion: String = "X" // 완료일
    @Published var simpleSwHistory: RoundHistory = RoundHistory() // 히스토리
    
    @Published var simpleStopState: TimerState = .cancelled {
        didSet { handleStopState(simpleStopState) }
    }
    
    // MARK: - 공통
    @Published var simpleRoundPhase: SimpleRoundPhase?
    @Published var phaseBackgroundColor: Color = .clear
    @Published var controlBtn: Bool = false // 바인딩할 프로퍼티
    
    var timerCancellable: AnyCancellable? // 타이머 메모리 날리기 용
    var activity: Activity<TimerWidgetAttributes>? // 라이브 액티비티
    
    let simpleButtonType: [SimpleButton] = [.preparation, .movements, .rest, .round]
    
    //    var timerEngine: SimpleTimerEngine
    //    var stopwatchEngine: SimpleStopwatchEngine
    
    // Engines
    var engine: PhaseEngine
    var engineMode: EngineMode = .timer
    
    init(engine: PhaseEngine = PhaseEngine(mode: .timer)) {
        self.engine = engine
        super.init()
        bindEngine()
    }
    
}

// MARK: - state methods
extension SimpleViewModel {
    
    // MARK: - bindEngine
    private func bindEngine() {
        
        engine.onTick = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                self.simpleDisplay = self.engine.display
                self.simpleTotalTime = self.engine.totalTime
                self.updateContentState(self.simpleRoundPhase,
                                        self.simpleTmRoundIdx,
                                        self.simpleDisplay)
                self.updateSimpleUnitProgress()
            }
        }
        
        engine.onPhaseCompleted = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                self.handleEnginePhaseCompleted()
            }
        }
        
        engine.onActive = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                // when engine reports active, ensure UI shows running state (no pause overlay)
                self.controlBtn = false
            }
        }
        engine.onPaused = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                self.controlBtn = true
            }
        }
        engine.onResumed = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                self.controlBtn = false
            }
        }
        engine.onCancelled = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                // cleanup UI
                self.simpleRoundPhase = .completed
                self.simpleDisplay = 0
                self.updateBackgroundColor()
            }
        }
        engine.onCompleted = { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                self.simpleRoundPhase = .completed
                self.simpleDisplay = 0
                self.updateBackgroundColor()
                self.simpleTimerCompletion = Date().formatted("yyyy-MM-dd HH:mm:ss")
            }
        }
    } // bindEngine
    
    // MARK: - Configure Engine
    // ...
    
    private func configureEngineForTimer() {
        engine.mode = .timer
        engine.rounds = simpleTmRounds
    }
    
    private func configureEngineForStopwatch() {
        engine.mode = .stopwatch
        engine.rounds = simpleSwRounds
    }
    
    // MARK: - handleEnginePhaseCompleted
    private func handleEnginePhaseCompleted() {
        guard let currentPhase = simpleRoundPhase else { return }
        nextPhaseFrom(currentPhase: currentPhase)
    } // handleEnginePhaseCompleted
    
    // MARK: - nextPhaseFrom
    private func nextPhaseFrom(currentPhase: SimpleRoundPhase) {
        guard let idx = simpleTmRoundIdx ?? simpleSwRoundIdx else { return }
        let rounds = engine.rounds
        let isLastRound = (idx == rounds.count - 1)
        
        switch currentPhase.next(isLastRound: isLastRound) {
        case .preparation: applyPreparationPhase(at: idx)
        case .movement:    applyMovementPhase(at: idx)
        case .rest:        applyRestPhase(at: idx)
        case .completed:   moveToNextRoundOrFinish(from: idx)
        }
    } // nextPhaseFrom
    
    // MARK: - applyPreparationPhase
    private func applyPreparationPhase(at idx: Int) {
        simpleDisplay = engine.mode == .timer
        ? selectedPreparationAmount
        : selectedPreparationStop
        
        simpleRoundPhase = .preparation
        updateBackgroundColor()
        
        engine.phase = .preparation
        engine.currentRoundIndex = idx
        engine.display = simpleDisplay
        engine.totalTime = simpleTotalTime
        engine.start()
    } // applyPreparationPhase
    
    // MARK: - applyMovementPhase
    private func applyMovementPhase(at idx: Int) {
        let round = engine.rounds[idx]
        simpleDisplay = round.movement
        
        simpleRoundPhase = .movement
        updateBackgroundColor()
        
        engine.phase = .movement
        engine.currentRoundIndex = idx
        engine.display = simpleDisplay
        engine.totalTime = simpleTotalTime
        engine.start()
    } // applyMovementPhase
    
    // MARK: - applyRestPhase
    private func applyRestPhase(at idx: Int) {
        let round = engine.rounds[idx]
        simpleDisplay = round.rest
        
        simpleRoundPhase = .rest
        updateBackgroundColor()
        
        engine.phase = .rest
        engine.currentRoundIndex = idx
        engine.display = simpleDisplay
        engine.totalTime = simpleTotalTime
        engine.start()
    } // applyRestPhase
    
    // MARK: - moveToNextRoundOrFinish
    private func moveToNextRoundOrFinish(from idx: Int) {
        let nextIdx = idx + 1
        if nextIdx >= engine.rounds.count {
            simpleRoundPhase = .completed
            simpleTimerState = .completed
            
            simpleDisplay = 0
            updateBackgroundColor()
            updateContentState(.completed, 0, 0)
            simpleTimerCompletion = Date().formatted("yyyy-MM-dd HH:mm:ss")
        } else {
            simpleTmRoundIdx = nextIdx
            applyPreparationPhase(at: nextIdx)
        }
    } // moveToNextRoundOrFinish
    
    // MARK: - handleTimerState
    private func handleTimerState(_ state: TimerState) {
        switch state {
        case .cancelled:
            engine.cancel()
            simpleDisplay = 0
            updateSimpleCompletionDate()
            
        case .completed:
            engine.stopTicking()
            simpleDisplay = 0
            updateSimpleCompletionDate()
            
        case .active:
            configureEngineForTimer()
            if simpleTmRoundIdx == nil {
                nextSimpleTimerRound()
            } else {
                engine.start()
            }
            
        case .paused:
            engine.pause()
            updateSimpleCompletionDate()
            
        case .resumed:
            engine.resume()
        }
    } // handleTimerState
    
    // MARK: - handleStopState
    private func handleStopState(_ state: TimerState) {
        switch state {
        case .cancelled:
            engine.cancel()
            simpleDisplay = 0
            updateSimpleCompletionDate()
            
        case .completed:
            engine.stopTicking()
            nextSimpleStopwatchRound()
            
        case .active:
            configureEngineForStopwatch()
            if simpleSwRoundIdx == nil {
                nextSimpleStopwatchRound()
            } else {
                engine.start()
            }
            
        case .paused:
            engine.pause()
            updateSimpleCompletionDate()
            
        case .resumed:
            engine.resume()
        }
    } // handleStopState
    
} // state methods
