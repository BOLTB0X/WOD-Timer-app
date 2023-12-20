//
//  WodViewModel+SimpleTimer.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import SwiftUI
import Combine

// MARK: - SimpleViewModel+SimpleTimer: SimpleTimer Update
// 업데이트 관련 메소드들
extension SimpleViewModel {
    // MARK: - Update Methods
    // .....
    // MARK: - updateCompletionDate
    func updateSimpleCompletionDate() {
        simpleCompletion = Date().addingTimeInterval(Double(simpleDisplay))
        print("완료", simpleCompletion ?? "")
        return
    }
    
    // MARK: - createSimpleTimerRounds
    // 스타트 신호를 받으면 타이머을 돌린 배열에 넣어줌
    func createSimpleTimerRounds() {
        simpleTmRounds = [] // 초기화
        
        for i in 0..<selectedRoundAmount {
            if i == selectedRoundAmount - 1 {
                simpleTmRounds.append((selectedMovementAmount.totalSeconds, 0))
            } else {
                simpleTmRounds.append((selectedMovementAmount.totalSeconds, selectedRestAmount.totalSeconds))
            }
        }
        
        simpleTotalTime = simpleTmRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
        return
    }
    
    /*==================================================================================*/
    // MARK: - phase, Round Update Method
    // ...
    // MARK: - nextSimpleTimerRound
    // 다음 라운드로 이동
    func nextSimpleTimerRound() {
        if simpleTmRounds.isEmpty { return }
        
        // 첫 시작, 준비 카운트를 진행해야할지 판단
        if isTimerFirstStart() {
            return
        }
        
        // 루틴배열(simpleRounds)의 인덱스를 변경
        movingIndex_InSimpleTimerRounds()
        return
    }
    
    // MARK: - isFirstStart
    // 루틴 타이머가 첫 시작인지 체크 메소드
    func isTimerFirstStart() -> Bool {
        // 첫 시작, 준비 카운트부터
        if simpleTmRoundIdx == nil {
            simpleTmRoundIdx = 0
            simpleRoundPhase = .preparation
            updateBackgroundColor()
            
            simpleDisplay = selectedPreparationAmount
            simpleState = controlBtn ? .paused : .active
            
            return true
        } else {
            return false
        }
    }
    
    // MARK: - isStopFirstStart
    func isStopFirstStart() -> Bool {
        // 첫 시작, 준비 카운트부터
        if simpleTmRoundIdx == nil {
            simpleTmRoundIdx = 0
            simpleRoundPhase = .preparation
            updateBackgroundColor()
            simpleDisplay = selectedPreparationStop
            simpleStopState = controlBtn ? .paused : .active
            
            return true
        } else {
            return false
        }
    }
    
    // MARK: - movingIndex_In_simpleRounds
    // simpleRounds 루틴배열 인덱스가 움직일 때, update 메소드
    func movingIndex_InSimpleTimerRounds() {
        guard let _ = simpleTmRoundIdx else { return }
        
        simpleTmRoundIdx! += 1
        
        guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count else {
            // 더 이상 진행할 라운드가 없으면 완료 상태로 변경
            simpleRoundPhase = .completed
            simpleState = .completed
            simpleDisplay = 0
            updateBackgroundColor()
            print("완료")
            return
        }
        
        let currentRound = simpleTmRounds[idx]
        simpleDisplay = currentRound.movement
        simpleRoundPhase = .movement
        updateBackgroundColor()
        simpleState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - nextSimpleRoundPhase
    // 라운드의 다음 단계로 이동
    func nextSimpleTimerRoundPhase() {
        guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count else {
            return
        }
        
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleTmRounds[idx]
        
        switch currentPhase {
        case .preparation:
            movementFromPreparation(currentRound: currentRound)
            
        case .movement:
            restFromMovement(currentRound: currentRound, idx: idx)
            
        case .rest:
            // 현재 라운드의 모든 단계가 완료된 경우 -> 다음 라운드로 이동
            nextSimpleTimerRound()
            
        default:
            break
        } // switch
    }
    
    // MARK: - updateSimpleUnitProgress
    // progress 업데이트
    func updateSimpleUnitProgress() {
        guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count else {
            return
        }
        
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleTmRounds[idx]
        
        calculateProgress(currentPhase: currentPhase, currentRound: currentRound)
        print(simpleUnitProgress)
        
        return
    }
    
    /*==================================================================================*/
    // MARK: - in using
    // ...
    // MARK: - movementFromPreparation
    // 준비 -> 운동
    private func movementFromPreparation(currentRound: (movement: Int, rest: Int)) {
        simpleDisplay = currentRound.movement
        simpleRoundPhase = .movement
        updateBackgroundColor()
        simpleState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - restFromMovement
    // 운동 -> 휴식
    private func restFromMovement(currentRound: (movement: Int, rest: Int), idx: Int) {
        if currentRound.rest > 0 || idx < selectedRoundAmount - 1 {
            simpleDisplay = currentRound.rest
            simpleRoundPhase = .rest
            updateBackgroundColor()
            simpleState = controlBtn ? .paused : .active
        } else { // 마지막 라운드인 경우
            nextSimpleTimerRound()
        }
        return
    }
    
    // MARK: - calculateProgress
    // 현재 단계별 프로그래스 계산
    private func calculateProgress(currentPhase: SimpleRoundPhase, currentRound: (movement: Int, rest: Int)) {
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
        return
    }
}
