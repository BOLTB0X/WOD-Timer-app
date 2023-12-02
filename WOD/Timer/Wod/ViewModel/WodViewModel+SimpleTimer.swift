//
//  WodViewModel+SimpleTimer.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import SwiftUI
import Combine

// MARK: - WodViewModel+SimpleTimer: SimpleTimer Methods
extension WodViewModel {
    // MARK: - Control Methods
    /// ...
    // MARK: - startTimer
    func startSimpleTimer() {
        print("타이머 실행")
        print(simpleRoundPhase?.phaseText ?? "??")

        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                print(self.simpleDisplay) // 확인
                if self.simpleDisplay > 0 && self.simpleRoundPhase != .preparation {
                    self.simpleTotalTime -= 1
                }
                self.simpleDisplay -= 1
                if self.simpleDisplay < 0 {
                    self.timerCancellable?.cancel()
                    self.simpleState = .completed
                    
                    // 다음 라운드 페이즈로 이동
                    self.nextSimpleRoundPhase()
                }
            }
    }
    
    // MARK: - pauseSimpleTimer
    // 일시 중지
    func pauseSimpleTimer() {
        simpleState = .paused
        timerCancellable?.cancel()
        print("일시중지")
        return
    }
    
    // MARK: - resumeSimpleTimer
    // 재개
    func resumeSimpleTimer() {
        simpleState = .resumed
        print("재개")
        startSimpleTimer()
        return
    }
    
    // MARK: - updateCompletionDate
    func updateSimpleCompletionDate() {
        simpleCompletion = Date().addingTimeInterval(Double(simpleDisplay))
        print("완료", simpleCompletion ?? "")
        return
    }
    
    // MARK: - Update Methods
    /// .....
    // MARK: - simpleStartTouched
    // 스타트 신호를 받으면 타이머을 돌린 배열에 넣어줌
    func simpleStartTouched() {
        for i in 0..<selectedRoundAmount {
            if i == selectedRoundAmount - 1 {
                simpleRounds.append((selectedMovementAmount.totalSeconds, 0))
            } else {
                simpleRounds.append((selectedMovementAmount.totalSeconds, selectedRestAmount.totalSeconds))
            }
        }
        
        simpleTotalTime = simpleRounds.map { $0.movement + $0.rest }.reduce(0, +)
        //print(simpleRounds, simpleTotalTime)
        return
    }
    
    // MARK: - simpleRestart
    // 재시작
    func simpleRestart() {
        simpleRoundIdx = nil
        simpleTotalTime = simpleRounds.map { $0.movement + $0.rest }.reduce(0, +)
        nextSimpleRound()
        return
    }
    
    // MARK: - moveToNextRound
    // 다음 라운드로 이동
    func nextSimpleRound() {
        if simpleRounds.isEmpty {
            return
        }
        
        if simpleRoundIdx == nil {
            // 첫 시작, 준비 카운트부터
            simpleRoundIdx = 0
            simpleRoundPhase = .preparation
            updateBackgroundColor()
            simpleDisplay = selectedPreparationAmount
            simpleState = .active
            return
        }
        
        simpleRoundIdx! += 1
        
        guard simpleRoundIdx! < simpleRounds.count else {
            // 더 이상 진행할 라운드가 없으면 완료 상태로 변경
            simpleRoundPhase = .completed
            simpleState = .completed
            print("완료")
            return
        }
        
        let currentRound = simpleRounds[simpleRoundIdx!]
        simpleDisplay = currentRound.movement
        simpleRoundPhase = .movement
        updateBackgroundColor()
        simpleState = .active
        return
    }
    
    // MARK: - nextSimpleRoundPhase
    // 라운드의 다음 단계로 이동
    private func nextSimpleRoundPhase() {
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleRounds[simpleRoundIdx!]
        
        switch currentPhase {
        case .preparation:
            simpleDisplay = currentRound.movement
            simpleRoundPhase = .movement
            updateBackgroundColor()
            simpleState = .active
            
        case .movement:
            if currentRound.rest > 0 || simpleRoundIdx! < selectedRoundAmount - 1 {
                simpleDisplay = currentRound.rest
                simpleRoundPhase = .rest
                updateBackgroundColor()
                simpleState = .active
            } else { // 마지막 라운드인 경우
                nextSimpleRound()
            }
            
        case .rest:
            // 현재 라운드의 모든 단계가 완료된 경우 다음 라운드로 이동
            nextSimpleRound()
            
        default:
            break
        }
    }
}
