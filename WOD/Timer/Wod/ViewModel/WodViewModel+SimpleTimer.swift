//
//  WodViewModel+SimpleTimer.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import Foundation
import Combine

// MARK: - Simple Timer
extension WodViewModel {
    // MARK: - displaySetValue
    func displaySetValue(_ state: String) -> String {
        switch state {
        case "Round":
            return String(selectedRoundAmount)
        case "Preparation":
            return String(format: "00:%02d", selectedPreparationAmount)
        case "Movements":
            return String(format: "%02d:%02d:%02d",
                          selectedMovementAmount.hours,
                          selectedMovementAmount.minutes,
                          selectedMovementAmount.seconds)
        case "Rest":
            return String(format: "%02d:%02d", selectedRestAmount.minutes,selectedRestAmount.seconds)
        default:
            return ""
        }
    }
    
    // MARK: - simpleStartTouched
    func simpleStartTouched() {
        simpleRounds = Array(repeating: Round(preparationTime: MovementTime(seconds: selectedPreparationAmount),
                                              movementTime: selectedMovementAmount,
                                              restTime: selectedRestAmount), count: selectedRoundAmount)
        simpleTotalTime = simpleRounds.reduce(0) { $0 + $1.totalTime }
    }
    
    // MARK: - startSimpleRoutine
    func startSimpleRoutine() {
        print("실행")
        guard !simpleRounds.isEmpty else {
            print("비어있음")
            return
        }
        // 첫 번째 라운드의 타이머 설정
        startTimerForCurrentRound()
    }
    
    // MARK: - startTimerForCurrentRound
    func startTimerForCurrentRound() {
        guard currentRoundIndex < simpleRounds.count else {
            print("루프 순회 완료")
            return
        }
        
        let currentRound = simpleRounds[currentRoundIndex]
        print("타이머 실행")
        // 각 타이머 시작
        startTimer(for: currentRound.preparationTime) { // 준비
            self.startTimer(for: currentRound.movementTime) {
                self.startTimer(for: currentRound.restTime) {
                    // 모든 타이머가 완료되면 다음 라운드로 이동
                    self.moveToNextRound()
                }
            }
        }
    }
    
    // MARK: - startTimer
    func startTimer(for time: MovementTime, completion: @escaping () -> Void) {
        let timer = TimerMonitor(totalTimeForCurrentSelection: time.totalSeconds)
        
        timer.$state.sink { state in
            guard state == .completed else { return }
            completion()
        }.store(in: &cancellables)
        
        timer.state = .active
    }
    
    // MARK: - moveToNextRound
    // 다음 라운드로 이동
    func moveToNextRound() {
        guard currentRoundIndex < simpleRounds.count else {
            // 모든 라운드가 완료되었을 때의 처리
            return
        }
        
        // 현재 라운드 인덱스를 증가시킴
        currentRoundIndex += 1
        
        // 다음 라운드를 위한 타이머 설정
        startTimerForCurrentRound()
    }
    
    // MARK: - pauseTimer
    func pauseTimer() {
        cancellables.forEach { $0.cancel() }
        simpleRounds[currentRoundIndex].elapsedMovementTime = simpleRounds[currentRoundIndex].movementTime
        simpleRounds[currentRoundIndex].elapsedRestTime = simpleRounds[currentRoundIndex].restTime
        timerState = .paused
    }
    
    // MARK: - resumeTimer
    func resumeTimer() {
        startTimerForCurrentRound()
        timerState = .resumed
    }
    
    // MARK: - displayCurrentPhase
    func displayCurrentPhase() -> String {
        guard currentRoundIndex < simpleRounds.count else {
            return ""
        }
        
        let currentPhase = currentSimpleRoundPhase
        
        switch currentPhase {
        case .preparation:
            return String(format: "00:%02d", simpleRounds[currentRoundIndex].elapsedPreparationTime.seconds)
        case .movement:
            return String(format: "%02d:%02d:%02d",
                          simpleRounds[currentRoundIndex].elapsedMovementTime.hours,
                          simpleRounds[currentRoundIndex].elapsedMovementTime.minutes,
                          simpleRounds[currentRoundIndex].elapsedMovementTime.seconds)
        case .rest:
            return String(format: "%02d:%02d", simpleRounds[currentRoundIndex].elapsedRestTime.minutes, simpleRounds[currentRoundIndex].elapsedRestTime.seconds)
        }
    }
}
