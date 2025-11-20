//
//  PhaseStateHandler.swift
//  Timer
//
//  Created by KyungHeon Lee on 9/26/25.
//

// MARK: - PhaseStateHandler
protocol PhaseStateHandler {
    var onCancelled: (() -> Void)? { get set }
    var onCompleted: (() -> Void)? { get set }
    var onActive: (() -> Void)? { get set }
    var onPaused: (() -> Void)? { get set }
    var onResumed: (() -> Void)? { get set }
    
    func handlePhaseStateChange(_ state: TimerState)
} // PhaseStateHandler

// MARK: - methods
extension PhaseStateHandler {
    
    // MARK: - handlePhaseStateChange
    func handlePhaseStateChange(_ state: TimerState) {
        switch state {
        case .cancelled:
            onCancelled?()
        case .completed:
            onCompleted?()
        case .active:
            onActive?()
        case .paused:
            onPaused?()
        case .resumed:
            onResumed?()
        }
    } // handlePhaseStateChange
    
} // PhaseStateHandler
