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
        guard !simpleRounds.isEmpty else { return }

        // 첫 번째 라운드의 타이머 설정
        setupTimerForCurrentRound()
    }

    // MARK: - setupTimerForCurrentRound
    // 현재 라운드의 타이머 설정
    func setupTimerForCurrentRound() {
        guard currentRoundIndex < simpleRounds.count else {
            // 모든 라운드가 완료되었을 때의 처리
            return
        }

        let currentRound = simpleRounds[currentRoundIndex]
        
        for i in 0..<3 {
            // 타이머 모니터 생성
            if i == 0 {
                timerMonitor = TimerMonitor(totalTimeForCurrentSelection: currentRound.preparationTime.totalSeconds)
            } else if i == 1 {
                timerMonitor = TimerMonitor(totalTimeForCurrentSelection: currentRound.movementTime.totalSeconds)
            } else {
                timerMonitor = TimerMonitor(totalTimeForCurrentSelection: currentRound.restTime.totalSeconds)
            }
            
            // 타이머 모니터 상태 감시
            timerMonitor?.$state.sink { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .cancelled:
                    // 현재 라운드의 타이머 완료 시 다음 라운드로 이동
                    self.moveToNextRound()
                default:
                    break
                }
            }.store(in: &cancellables)
            
            // 타이머 모니터 시작
            timerMonitor?.state = .active
        }
    }
    
    //MARK: - moveToNextRound
    // 다음 라운드로 이동
    func moveToNextRound() {
        guard currentRoundIndex < simpleRounds.count - 1 else {
            // 모든 라운드가 완료되었을 때의 처리
            return
        }

        // 현재 라운드 인덱스를 증가시킴
        currentRoundIndex += 1

        // 다음 라운드를 위한 타이머 설정
        setupTimerForCurrentRound()
    }
}
