//
//  DetailViewModel+UpdateTimer.swift
//  Timer
//
//  Created by lkh on 1/2/24.
//

import SwiftUI

// MARK: - DetailViewModel+DetailTimer: DetailTimer Update
// 업데이트 관련 메소드들
extension DetailViewModel {
    // MARK: - Update Methods
    // .....
    // MARK: - createDetailTimerRounds
    // 스타트 신호를 받으면 타이머을 돌린 배열에 넣어줌
    func createDetailTimerRounds() {
        detailTmRounds = [] // 초기화
        
        for i in 0..<selectedRoundAmount {
            if i == selectedRoundAmount - 1 {
                detailTmRounds.append(DetailRound(movement: timerLoopList, loopRest: 0, date: StartComplted()))
            } else {
                detailTmRounds.append(DetailRound(movement: timerLoopList, loopRest: selectedLoopRestAmount.totalSeconds, date: StartComplted()))
            } // if - else
        } // for
        
        detailTotalTime = detailTmRounds.reduce(0) { $0 + ($1.totalMovementTime + $1.loopRest) }
        return
    }
    
    // MARK: - updateDetailTimerCompletion
    func updateDetailTimerCompletion() {
        guard let idx = detailTmRoundIdx, let currentPhase = detailRoundPhase else { return }
        
        if currentPhase == .movement {
            detailTmRounds[idx].date.movementComplted = Date().formatted("yyyy-MM-dd HH:mm:ss")
        } else if currentPhase == .rest {
            detailTmRounds[idx].date.restComplted = Date().formatted("yyyy-MM-dd HH:mm:ss")
        }
        
        return
    }
    
    /*==================================================================================*/
    // MARK: - phase, Round Update Method
    // ...
    // MARK: - nextSimpleTimerRound
    // 다음 라운드로 이동
    func nextSimpleTimerRound() {
        if detailTmRounds.isEmpty { return }
        
        // 첫 시작, 준비 카운트를 진행해야할지 판단
        if isTimerFirstStart() {
            return
        }
        
        // 루틴배열(simpleRounds)의 인덱스를 변경
        movingIndex_InDetailTimerRounds()
        return
    }
    
    // MARK: - isFirstStart
    // 루틴 타이머가 첫 시작인지 체크 메소드
    func isTimerFirstStart() -> Bool {
        // 첫 시작, 준비 카운트부터
        if detailTmRoundIdx == nil {
            detailTmRoundIdx = 0
            detailRoundPhase = .preparation
            //updateBackgroundColor()
            
            detailDisplay = selectedPreparationAmount
            detailState = controlBtn ? .paused : .active
            return true
        } else {
            return false
        }
    }
    
    // MARK: - movingIndex_InDetailTimerRounds
    // simpleRounds 루틴배열 인덱스가 움직일 때, update 메소드
    func movingIndex_InDetailTimerRounds() {
        guard let _ = detailTmRoundIdx else { return }
        
        detailTmRoundIdx! += 1
        
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            // 더 이상 진행할 라운드가 없으면 완료 상태로 변경
            detailRoundPhase = .completed
            detailState = .completed
            detailDisplay = 0
            //updateBackgroundColor()
            detailTimerCompletion = Date().formatted("yyyy-MM-dd HH:mm:ss")
            
            // 테스트
            for tm in detailTmRounds {
                print("운동 시작 시간: ", tm.date.movementStart)
                print("운동 완료 시간: ", tm.date.movementComplted)
                print("휴식 시작 시간: ", tm.date.restStart)
                print("휴식 완료 시간: ", tm.date.restComplted)
                print("===================================================")
            }
            print("총 타이머 완료", detailTimerCompletion)
            return
        }
        
        let currentRound = detailTmRounds[idx]
        //detailDisplay = currentRound.totalMovementTime.
        detailRoundPhase = .movement
        //updateBackgroundColor()
        detailState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - nextDetailTimerRoundPhase
    // 라운드의 다음 단계로 이동
    func nextDetailTimerRoundPhase() {
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            return
        }
        
        guard let currentPhase = detailRoundPhase else { return }
        let currentRound = detailTmRounds[idx]
        
        switch currentPhase {
        case .preparation:
            break
            //movementFromPreparation(currentRound: currentRound)
            
        case .movement:
            break
            //restFromMovement(currentRound: currentRound, idx: idx)
            
        case .rest:
            // 현재 라운드의 모든 단계가 완료된 경우 -> 다음 라운드로 이동
            nextSimpleTimerRound()
            
        default:
            break
        } // switch
    }
    
    // MARK: - updateDetailUnitProgress
    // progress 업데이트
    func updateDetailUnitProgress() {
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            return
        }
        
        guard let currentPhase = detailRoundPhase else { return }
        let currentRound = detailTmRounds[idx]
        
        //calculateProgress(currentPhase: currentPhase, currentRound: currentRound)
        print(detailUnitProgress)
        
        return
    }
}
