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
        
        detailTotalTime = detailTmRounds.reduce(0) { $0 + ($1.totalMovementTime + $1.roundRest) }
        return
    }
    
    // MARK: - updateDetailTimerCompletion
    func updateDetailTimerCompletion() {
        guard let idx = detailTmRoundIdx, let currentPhase = detailRoundPhase else { return }
        
        if currentPhase == .loopMovement || currentPhase == .loopRest {
            detailTmRounds[idx].date.movementComplted = Date().formatted("yyyy-MM-dd HH:mm:ss")
        } else if currentPhase == .rest {
            detailTmRounds[idx].date.restComplted = Date().formatted("yyyy-MM-dd HH:mm:ss")
        }
        
        return
    }
    
    
    /*==================================================================================*/
    // MARK: - phase, Round Update Method
    // ...
    // MARK: - nextDetailTimerRound
    // 다음 라운드로 이동
    func nextDetailTimerRound() {
        if detailTmRounds.isEmpty { return }
        
        // 첫 시작, 준비 카운트를 진행해야할지 판단
        if isTimerFirstStart() { return }
      
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
            updateBackgroundColor()
            
            detailDisplay = selectedPreparationAmount
            detailState = controlBtn ? .paused : .active
            return true
        } else {
            return false
        }
    }
    
    // MARK: - movingIndex_InDetailTimerRounds
    // detailRounds 배열 인덱스가 움직일 때, update 메소드
    func movingIndex_InDetailTimerRounds() {
        guard let _ = detailTmRoundIdx else { return }
        
        detailTmRoundIdx! += 1
        
        // 완료
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            // 더 이상 진행할 라운드가 없으면 완료 상태로 변경
            detailRoundPhase = .completed
            detailState = .completed
            detailDisplay = 0
            updateBackgroundColor()
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
        detailDisplay = currentRound.movement[selectedTimerLoopIndex].time.totalSeconds
        detailRoundPhase = .loopMovement
        
        updateBackgroundColor()
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
            movementFromPreparation(currentRound: currentRound)
            
        case .loopMovement, .loopRest:
            timerLoopIndexing(currentRound: currentRound)
            //restFromMovement(currentRound: currentRound, idx: idx)
            
        case .rest:
            // 현재 라운드의 모든 단계가 완료된 경우 -> 다음 라운드로 이동
            nextDetailTimerRound()
            
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
        
        calculateProgress(currentPhase: currentPhase, currentRound: currentRound)
        //print(detailUnitProgress)
        
        return
    }
    
    // MARK: - updateTimerPhaseStart
    // 각 루틴 실행 기록 업데이트
    func updateTimerPhaseStart(idx: Int, currentPhase: DetailRoundPhase) {
        if currentPhase == .loopMovement && detailTmRounds[idx].date.movementStart == "" {
            detailTmRounds[idx].date.movementStart = Date().formatted("yyyy-MM-dd HH:mm:ss")
        } else if currentPhase == .rest && detailTmRounds[idx].date.restStart == "" {
            detailTmRounds[idx].date.restStart = Date().formatted("yyyy-MM-dd HH:mm:ss")
        }
        return
    }
    
    /*==================================================================================*/
    // MARK: - in using
    // ...
    // MARK: - movementFromPreparation
    // 준비 -> 운동
    private func movementFromPreparation(currentRound: DetailRound) {
        guard let currentLoop = currentRound.movement.first else { return }
        
        detailDisplay = currentLoop.time.totalSeconds
        detailRoundPhase = .loopMovement
        updateBackgroundColor()
        detailState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - timerLoopIndexing
    private func timerLoopIndexing(currentRound: DetailRound) {
        selectedTimerLoopIndex += 1
        
        if selectedTimerLoopIndex < timerLoopList.count {
            let timerLoop = currentRound.movement[selectedTimerLoopIndex]
            detailDisplay = timerLoop.time.totalSeconds
            detailRoundPhase = timerLoop.type == .movement ? .loopMovement : .loopRest
            updateBackgroundColor()
            detailState = controlBtn ? .paused : .active
        } else {
            selectedTimerLoopIndex = 0
            nextDetailTimerRound()
        }
        return
    }
    
    // MARK: - restFromMovement
    // 운동 -> 휴식
    private func restFromMovement(currentRound: DetailRound, idx: Int) {
        let currentLoop = currentRound.movement
        selectedTimerLoopIndex += 1

        if selectedTimerLoopIndex < currentLoop.count {
            detailDisplay = currentLoop[selectedTimerLoopIndex].time.totalSeconds
            if currentLoop[selectedTimerLoopIndex].type == .movement {
                detailRoundPhase = .loopMovement
            } else {
                detailRoundPhase = .loopRest
            }
            updateBackgroundColor()
            detailState = controlBtn ? .paused : .active
        } else {
            if currentRound.roundRest > 0 || idx < selectedRoundAmount - 1 {
                detailDisplay = currentRound.roundRest
                detailRoundPhase = .rest
                updateBackgroundColor()
                detailState = controlBtn ? .paused : .active
            } else { // 마지막 라운드인 경우
                selectedTimerLoopIndex = 0
                nextDetailTimerRound()
            }
        }
        return
    }
    
    // MARK: - calculateProgress
    // 현재 단계별 프로그래스 계산
    private func calculateProgress(currentPhase: DetailRoundPhase, currentRound: DetailRound) {
        switch currentPhase {
        case .preparation:
            let elapsedTime = selectedPreparationAmount - detailDisplay
            detailUnitProgress = Float(elapsedTime) / Float(selectedPreparationAmount)
        case .loopMovement, .loopRest:
            let totalSeconds = currentRound.movement[selectedTimerLoopIndex].time.totalSeconds
            let elapsedTime = selectedMovementAmount.totalSeconds - detailDisplay
            detailUnitProgress = Float(elapsedTime) / Float(totalSeconds)
        case .rest:
            let totalSeconds = currentRound.roundRest
            let elapsedTime = selectedRestAmount.totalSeconds - detailDisplay
            detailUnitProgress = Float(elapsedTime) / Float(totalSeconds)
        default:
            detailUnitProgress = 0.0
        }
        return
    }
}
