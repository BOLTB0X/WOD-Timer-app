//
//  GeneralTimerViewModel.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import Foundation
import Combine

class StopWatchViewModel: ObservableObject {
    @Published var manager: StopWatchModel = StopWatchModel(secElapsed: 0.000, lapElapsed: 0.000, lapTimes: [])
    private var timerCancellable: AnyCancellable?
    
    enum ScenePhase {
        case active
        case inactive
        case background
    }

    enum Mode {
        case running // 실행
        case paused // 잠시 멈춤
        case stopped // 진짜 멈춤
    }

    
    @Published var scene: ScenePhase = .active {
        didSet {
            switch scene {
            case .active:
                break;
            case .inactive:
                break;
            case .background:
                break;
            }
        }
    }
        
    @Published var mode: Mode = .stopped {
        didSet {
            switch mode {
            case .running:
                startTimer() // 실행
                break
            case .paused:
                pauseTimer() // 일시정지
                break
            case .stopped:
                stopTimer() // 종료
                break
            }
        }
    }
    
    // MARK: - ViewTimer Control
    func viewTimerRecord() {
        switch mode {
        case .running:
            userRecordTimer()
        case .stopped:
            return
        case .paused:
            userStopTimer()
        }
    }
    
    func viewTimerStartOrPause() {
        switch mode {
        case .running:
            userPauseTimer()
        case .paused:
            userStartTimer()
        case .stopped:
            userStartTimer()
        }
    }
    
    // MARK: - user Control
    func userStopTimer() {
        mode = .stopped
    }
    
    func userStartTimer() {
        mode = .running
    }
    
    func userPauseTimer() {
        mode = .paused
    }
    
    func userRecordTimer() {
        manager.lapTimes.append(manager.selectedLap)
        manager.lapElapsed = 0.000
    }
    
    // MARK: - Timer Control
    func startTimer() {
        timerCancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.manager.secElapsed += 0.01
                self.manager.lapElapsed += 0.01
                self.objectWillChange.send()
            }
        )
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
        manager.secElapsed = 0.000
        manager.lapElapsed = 0.000
        manager.lapTimes.removeAll()
    }
    
    func pauseTimer() {
        timerCancellable?.cancel()
    }
}
