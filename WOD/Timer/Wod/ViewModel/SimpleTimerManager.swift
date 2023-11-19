//
//  SimpleTimerManager.swift
//  Timer
//
//  Created by lkh on 11/17/23.
//

import Foundation
import Combine

class SimpleTimerManager: ObservableObject {
    static var shared = SimpleTimerManager()
    
    @Published var rounds: [Round]
    @Published var totalTime: Double
    
    var timerCancellable: AnyCancellable?

    private init() {
        rounds = []
        totalTime = 0
        timerCancellable = nil
    }
    
    init (rounds: [Round]) {
        self.rounds = rounds
        totalTime = rounds.reduce(0) { $0 + Double($1.totalTime.totalSeconds) }
        
        startTimer()
    }

    func startTimer() {
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.updateTimerValues()
            }
    }
    
    private func updateTimerValues() {
        if var currentRound = rounds.first {
            if currentRound.preparationTime.seconds > 0 {
                currentRound.preparationTime.seconds -= 1
            } else if currentRound.movementTime.totalSeconds > 0 {
                currentRound.movementTime.seconds -= 1
            } else if currentRound.restTime.seconds > 0 {
                currentRound.restTime.seconds -= 1
            } else {
                // 현재 라운드 다 되었으면, 다음 라운드로 이동
                rounds.removeFirst()
                calculateTotalTime()
            }
        } else {
            // 모든 라운드 완료
            stopTimer()
        }
        
        // 변경된 값 전송
        objectWillChange.send()
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
    }
    
    private func calculateTotalTime() {
        totalTime = rounds.reduce(0) { $0 + Double($1.totalTime.totalSeconds) }
    }
}
