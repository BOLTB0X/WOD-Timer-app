//
//  SimpleViewModel+UpdateStopWatch.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import Foundation
import Combine

// MARK: - SimpleViewModel+StopWatch: SimpleStopWatch Update
// 스톱워치 업데이트 관련 메소드들
extension SimpleViewModel {
    // MARK: - Update Methods
    // .....
    // MARK: - createSimpleStopRounds
    // 스톱워치용 어차피 0부터 몇 초,분 운동을 했냐를 제는 거니
    func createSimpleStopRounds() {
        simpleSwRounds = []
        
        for i in 0..<selectedRoundStop {
            if i == selectedRoundStop - 1 {
                simpleSwRounds.append(Round(movement: 0, rest: -1, complted: ""))
            } else {
                simpleSwRounds.append(Round())
            }
        }
        
        simpleTotalTime = 0
        return
    }
    
    /*==================================================================================*/
    // MARK: - phase, Round Update Method
    // ...
    // MARK: - nextSimpleStopwatchRound
    // 다음 라운드로 이동
    func nextSimpleStopwatchRound() {
        if simpleSwRounds.isEmpty { return }
        
        // 첫 시작, 준비 카운트를 진행해야할지 판단
        if isStopwatchFirstStart() {
            return
        }
        
        // 루틴배열(simpleRounds)의 인덱스를 변경
        movingIndex_InSimpleStopwatchRounds()
        return
    }
    
    // MARK: - isFirstStart
    // 루틴 스톱워치가 첫 시작인지 체크 메소드
    func isStopwatchFirstStart() -> Bool {
        // 첫 시작, 준비 카운트부터
        if simpleSwRoundIdx == nil {
            simpleSwRoundIdx = 0
            simpleRoundPhase = .preparation
            updateBackgroundColor()
            
            simpleDisplay = selectedPreparationStop
            simpleStopState = controlBtn ? .paused : .active
            
            return true
        } else {
            return false
        }
    }
    
    // MARK: - movingIndex_InSimpleStopwatchRounds
    // simpleRounds 루틴배열 인덱스가 움직일 때, update 메소드
    func movingIndex_InSimpleStopwatchRounds() {
        guard let _ = simpleSwRoundIdx else { return }
        
        simpleSwRoundIdx! += 1
        
        guard let idx = simpleSwRoundIdx, idx < simpleSwRounds.count else {
            // 더 이상 진행할 라운드가 없으면 완료 상태로 변경
            simpleRoundPhase = .completed
            simpleState = .completed
            simpleDisplay = 0
            updateBackgroundColor()
            print("완료")
            return
        }
        
        let currentRound = simpleSwRounds[idx]
        simpleDisplay = 0
        simpleRoundPhase = .movement
        updateBackgroundColor()
        simpleStopState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - nextSimpleStopRoundPhase
    // 라운드의 다음 단계로 이동
    func nextSimpleStopRoundPhase() {
        guard let idx = simpleSwRoundIdx, idx < simpleSwRounds.count else {
            return
        }
        
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleSwRounds[idx]
        simpleDisplay = 0
        
        switch currentPhase {
        case .preparation:
            movementFromPreparation(currentRound: currentRound)
            //simpleSwRounds[idx].movement = simpleDisplay

        case .movement:
            restFromMovement(currentRound: currentRound, idx: idx)
            
        case .rest:
            // 현재 라운드의 모든 단계가 완료된 경우 -> 다음 라운드로 이동
            nextSimpleStopwatchRound()
            
        default:
            break
        } // switch
    }
    
    /*==================================================================================*/
    // MARK: - in using
    // ...
    // MARK: - movementFromPreparation
    // 준비 -> 운동
    private func movementFromPreparation(currentRound: Round) {
        simpleRoundPhase = .movement
        updateBackgroundColor()
        simpleStopState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - restFromMovement
    // 운동 -> 휴식
    private func restFromMovement(currentRound: Round, idx: Int) {
        if currentRound.rest > 0 || idx < selectedRoundStop - 1 {
            simpleRoundPhase = .rest
            updateBackgroundColor()
            simpleStopState = controlBtn ? .paused : .active
        } else { // 마지막 라운드인 경우
            nextSimpleStopwatchRound()
        }
        return
    }
}
