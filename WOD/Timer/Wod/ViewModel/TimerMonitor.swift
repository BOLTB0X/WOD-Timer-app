//
//  TimerViewModel.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import Foundation
import Combine

// MARK: - TimerMonitor
class TimerMonitor: ObservableObject {
    @Published var totalTimeForCurrentSelection: Int
    @Published var secondsToCompletion: Int = 0
    @Published var completionDate = Date()

    private var timerCancellable: AnyCancellable?
    
    init(totalTimeForCurrentSelection: Int) {
        self.totalTimeForCurrentSelection = totalTimeForCurrentSelection
    }

    enum TimerState {
        case active
        case paused
        case resumed
        case cancelled
    }

    @Published var state: TimerState = .cancelled {
        didSet {
            switch state {
            case .cancelled: // 취소
                timerCancellable?.cancel()
                secondsToCompletion = 0

            case .active: // 실행
                startTimer()
                secondsToCompletion = totalTimeForCurrentSelection
                updateCompletionDate()

            case .paused: // 중지
                timerCancellable?.cancel()

            case .resumed: // 재개
                startTimer()
                updateCompletionDate()
            }
        }
    }

    private func startTimer() {
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.secondsToCompletion -= 1
                if self.secondsToCompletion <= 0 {
                    self.state = .cancelled
                }
            }
    }

    private func updateCompletionDate() {
        completionDate = Date().addingTimeInterval(Double(secondsToCompletion))
    }
}
