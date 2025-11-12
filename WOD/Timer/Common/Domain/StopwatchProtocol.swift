//
//  StopwatchProtocol.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

// MARK: - StopwatchProtocol
protocol StopwatchProtocol: ObservableObject, PhaseStateHandler {
    var elapsedTime: Int { get set }
    var stopwatchState: TimerState { get set }
    var timerCancellable: AnyCancellable? { get set }

    func startStopwatch()
    func pauseStopwatch()
    func resumeStopwatch()
    func cancelStopwatch()
    func completeStopwatch()
} // StopwatchProtocol
