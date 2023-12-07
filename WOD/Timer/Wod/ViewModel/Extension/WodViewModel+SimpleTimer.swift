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
        guard let idx = simpleRoundIdx, idx < simpleRounds.count else {
            return
        }
        
        print("타이머 실행")
        print(simpleRoundPhase?.phaseText ?? "??")
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                //print(self.simpleDisplay) // 확인
                if self.simpleDisplay > 0 && self.simpleRoundPhase != .preparation {
                    self.simpleTotalTime -= 1
                }
                
                self.simpleDisplay -= 1
                self.updateSimpleUnitProgress()
                
                if self.simpleDisplay < 0 {
                    self.timerCancellable?.cancel()
                    self.simpleState = .completed
                    self.simpleUnitProgress = 0.0
                    // 다음 라운드 페이즈로 이동
                    self.nextSimpleRoundPhase()
                }
            }
    }
    
    // MARK: - pauseSimpleTimer
    // 일시 중지
    func pauseSimpleTimer() {
        timerCancellable?.cancel()
        print("일시중지")
        updateSimpleCompletionDate()
        return
    }
    
    // MARK: - resumeSimpleTimer
    // 재개
    func resumeSimpleTimer() {
        print("재개")
        updateSimpleCompletionDate()
        simpleState = .active
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
        simpleRounds = [] // 초기화
        
        for i in 0..<selectedRoundAmount {
            if i == selectedRoundAmount - 1 {
                simpleRounds.append((selectedMovementAmount.totalSeconds, 0))
            } else {
                simpleRounds.append((selectedMovementAmount.totalSeconds, selectedRestAmount.totalSeconds))
            }
        }
        
        simpleTotalTime = 0
        simpleTotalTime = simpleRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
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
        
        guard let idx = simpleRoundIdx, idx < simpleRounds.count else {
            // 더 이상 진행할 라운드가 없으면 완료 상태로 변경
            simpleRoundPhase = .completed
            simpleState = .completed
            print("완료")
            return
        }
        
        let currentRound = simpleRounds[idx]
        simpleDisplay = currentRound.movement
        simpleRoundPhase = .movement
        updateBackgroundColor()
        simpleState = .active
        return
    }
    
    // MARK: - updateSimpleUnitProgress
    // progress 업데이트
    private func updateSimpleUnitProgress() {
        guard let idx = simpleRoundIdx, idx < simpleRounds.count else {
            return
        }
        
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleRounds[idx]
        
        switch currentPhase {
        case .preparation:
            let elapsedTime = selectedPreparationAmount - simpleDisplay
            simpleUnitProgress = Float(elapsedTime) / Float(selectedPreparationAmount)
        case .movement:
            let totalSeconds = currentRound.movement
            let elapsedTime = selectedMovementAmount.totalSeconds - simpleDisplay
            simpleUnitProgress = Float(elapsedTime) / Float(totalSeconds)
        case .rest:
            let totalSeconds = currentRound.rest
            let elapsedTime = selectedRestAmount.totalSeconds - simpleDisplay
            simpleUnitProgress = Float(elapsedTime) / Float(totalSeconds)
        default:
            simpleUnitProgress = 0.0
        }
        
        print(simpleUnitProgress)
        return
    }
    
    // MARK: - nextSimpleRoundPhase
    // 라운드의 다음 단계로 이동
    private func nextSimpleRoundPhase() {
        guard let idx = simpleRoundIdx, idx < simpleRounds.count else {
            return
        }
        
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleRounds[idx]
        
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
            // 현재 라운드의 모든 단계가 완료된 경우 -> 다음 라운드로 이동
            nextSimpleRound()
            
        default:
            break
        }
    }
}
