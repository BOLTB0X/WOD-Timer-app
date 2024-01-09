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
        
        // 준비
        detailTmRounds.append(DetailTmRound(currentRound: 0, currentPhase: .preparation, title: "Preparation", time: MovementTime(seconds: selectedPreparationAmount)))
        
        for i in 0..<selectedRoundAmount {
            // Loop
            for j in 0..<timerLoopList.count {
                let round = i + 1
                let curPhase: DetailRoundPhase = timerLoopList[j].type == .movement ? .loopMovement : .loopRest
                let title = timerLoopList[j].title
                let time = timerLoopList[j].time
                let color = timerLoopList[j].color

                detailTmRounds.append(DetailTmRound(currentRound: round, currentPhase: curPhase, currentLoop: j+1, lengthLoop: timerLoopList.count, title: title, time: time, color: color))
            }
            
            // Rest
            if i == selectedRoundAmount - 1 {
                continue
            } else {
                detailTmRounds.append(DetailTmRound(currentRound: i+1, currentPhase: .rest, title: "Rest", time: selectedRestAmount))
            }
        }
        
        detailRTotalTime = detailTmRounds.reduce(0) { $0 + $1.time.totalSeconds } - selectedPreparationAmount
        //detailSTotalTime = 0
        return
    }
    
    // MARK: - updateDetailTimerCompletion
    func updateDetailTimerCompletion() {
        guard let idx = detailTmRoundIdx else { return }
        
        detailTmRounds[idx].endDate = Date().formatted("yyyy-MM-dd HH:mm:ss")
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
      
        nextTimer()
        return
    }
    
    // MARK: - isTimerFirstStart
    // 루틴 타이머가 첫 시작인지 체크 메소드
    func isTimerFirstStart() -> Bool {
        // 첫 시작, 준비 카운트 셋팅
        if detailTmRoundIdx == nil {
            detailTmRoundIdx = 0
            detailRoundPhase = .preparation
            updateTimerBackgroundColor()
            detailDisplay = detailTmRounds[0].time.totalSeconds
            detailTimerState = controlBtn ? .paused : .active
            return true
        }
        
        return false
    }
    
    // MARK: - nextTimer
    // 타이머 진행 메소드
    func nextTimer() {
        guard var idx = detailTmRoundIdx else { return }
        
        idx += 1
        
        // 타이머 셋팅 값을 다 순회했는지 가드
        guard idx < detailTmRounds.count else {
            detailRoundPhase = .completed
            detailTimerState = .completed
            detailDisplay = 0
            updateTimerBackgroundColor()
            detailTimerCompletion = Date().formatted("yyyy-MM-dd HH:mm:ss")
            return
        }
        
        // 인덱스 증가 -> 다음 타이머 셋팅으로
        detailTmRoundIdx! += 1
        detailRoundPhase = detailTmRounds[idx].currentPhase
        detailDisplay = detailTmRounds[idx].time.totalSeconds
        updateTimerBackgroundColor()
        detailTimerState = controlBtn ? .paused : .active
        return
    }

    
    // MARK: - updateDetailUnitProgress
    // progress 업데이트
    func updateDetailUnitProgress() {
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            return
        }
        
        guard let currentPhase = detailRoundPhase else { return }
        //let currentRound = detailTmRounds[idx]
        
        calculateProgress(currentPhase: currentPhase)
        return
    }
    
    // MARK: - updateTimerPhaseStart
    // 각 루틴 실행 기록 업데이트
    func updateTimerPhaseStart(idx: Int) {
        detailTmRounds[idx].startDate = Date().formatted("yyyy-MM-dd HH:mm:ss")
        return
    }
    
    /*==================================================================================*/
    // MARK: - in using
    // ..
    // MARK: - calculateProgress
    // 현재 단계별 프로그래스 계산
    private func calculateProgress(currentPhase: DetailRoundPhase) {
        switch currentPhase {
        case .preparation:
            let elapsedTime = selectedPreparationAmount - detailDisplay
            detailUnitProgress = Float(elapsedTime) / Float(selectedPreparationAmount)
        case .loopMovement, .loopRest:
            let totalSeconds = detailTmRounds[detailTmRoundIdx ?? 0].time.totalSeconds
            let elapsedTime = totalSeconds - detailDisplay
            detailUnitProgress = Float(elapsedTime) / Float(totalSeconds)
        case .rest:
            let totalSeconds = detailTmRounds[detailTmRoundIdx ?? 0].time.totalSeconds
            let elapsedTime = selectedRestAmount.totalSeconds - detailDisplay
            detailUnitProgress = Float(elapsedTime) / Float(totalSeconds)
        default:
            detailUnitProgress = 0.0
        }
        return
    }
}
