//
//  TimerManager.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

class TimerManager: ObservableObject {
    // MARK: - 프로퍼티
    @Published var timeManager: TimerModel = TimerModel(secElapsed: 0.000, lapElapsed: 0.000, lapTimes: [])
    private var timer = Timer()
    
    enum ScenePhase {
        case active
        case inactive
        case background
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
    
    enum Mode {
        case running // 실행
        case paused // 잠시 멈춤
        case stopped // 진짜 멈춤
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
        timeManager.lapTimes.append(timeManager.selectedLap)
        timeManager.lapElapsed = 0.000
    }
    
    // MARK: - Timer Control
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.010, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.timeManager.secElapsed += 0.010
            self.timeManager.lapElapsed += 0.010
            self.objectWillChange.send()
        })
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func stopTimer() {
        timer.invalidate()
        timeManager.secElapsed = 0.000
        timeManager.lapElapsed = 0.000
        timeManager.lapTimes.removeAll()
    }
    
    func pauseTimer() {
        timer.invalidate()
    }
}
