//
//  TimerViewModel.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import Foundation
import Combine

class TimerMonitor: ObservableObject {
    @Published var realTime: Double
    
    init(realTime: Double) {
        self.realTime = realTime
    }
    
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
    
    // MARK: - Timer Control
    func startTimer() {
        timerCancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.realTime -= 0.01
                self.objectWillChange.send()
            }
        )
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
        realTime = 0.00
    }
    
    func pauseTimer() {
        timerCancellable?.cancel()
    }
}
