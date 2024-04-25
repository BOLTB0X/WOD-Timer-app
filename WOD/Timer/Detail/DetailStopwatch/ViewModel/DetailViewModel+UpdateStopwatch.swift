//
//  DetailViewModel+UpdateStopwatch.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI

// MARK: - DetailViewModel+DetailStopwatch: DetailStopwatch Update
// 업데이트 관련 메소드들
extension DetailViewModel {
    // MARK: - Update Methods
    // .....
    // MARK: - createDetailStopRounds
    // 스타트 신호를 받으면 타이머을 돌린 배열에 넣어줌
    func createDetailStopRounds() {
        detailSwRounds = [] // 초기화
        
        // 준비
        detailSwRounds.append(DetailTmRound(currentRound: 0, currentPhase: .preparation, title: "Preparation" ,time: MovementTime(seconds: selectedPreparationStop)))
        
        for i in 0..<selectedRoundStop {
            // Loop
            for j in 0..<stopLoopList.count {
                let round = i + 1
                let curPhase: DetailRoundPhase = stopLoopList[j].type == .movement ? .loopMovement : .loopRest
                let title = stopLoopList[j].title
                let time = stopLoopList[j].time
                let color = stopLoopList[j].color

                detailSwRounds.append(DetailTmRound(currentRound: round, currentPhase: curPhase, currentLoop: j+1, lengthLoop: stopLoopList.count, title: title, time: time, color: color))
            }
            
            // Rest
            if i == selectedRoundStop - 1 {
                continue
            } else {
                detailSwRounds.append(DetailTmRound(currentRound: i+1, currentPhase: .rest, title: "Rest" ,time: MovementTime(seconds: 0)))
            }
        }
        
        detailSTotalTime = 0
        print("배열 완성")
        return
    }
    
    // MARK: - updateDetailTimerCompletion
    func updateDetailStopCompletion() {
        guard let idx = detailSwRoundIdx else { return }
        
        detailSwRounds[idx].endDate = Date().formatted("yyyy-MM-dd HH:mm:ss")
        return
    }
    
    // MARK: - updateDetailStopHistory
    func updateDetailStopHistory(state: String) {
        guard let idx = detailSwRoundIdx else { return }

        detailSwRounds[idx].history.append("\(state), \(Date().formatted("yyyy-MM-dd HH:mm:ss"))")

    }
    
    /*==================================================================================*/
    // MARK: - phase, Round Update Method
    // ...
    // MARK: - nextDetailStopRound
    // 다음 라운드로 이동
    func nextDetailStopRound() {
        if detailSwRounds.isEmpty {
            print("비어있음")
            return
        }
        
        // 첫 시작, 준비 카운트를 진행해야할지 판단
        if isStopFirstStart() {
            return
        }
      
        nextStopwatch()
        return
    }
    
    // MARK: - isStopFirstStart
    // 루틴 스톱워치가 첫 시작인지 체크 메소드
    func isStopFirstStart() -> Bool {
        // 첫 시작, 준비 카운트 셋팅
        if detailSwRoundIdx == nil {
            detailSwRoundIdx = 0
            detailRoundPhase = .preparation
            updateStopwatchBackgroundColor()
            detailDisplay = detailSwRounds[0].time.totalSeconds
            detailStopState = controlBtn ? .paused : .active
            print("준비 단계 시작, \(detailStopState)")
            requestOnLiveActivity()
            return true
        }
        
        return false
    }
    
    // MARK: - nextStopwatch
    func nextStopwatch() {
        guard var idx = detailSwRoundIdx else { return }
        
        idx += 1
        
        // 타이머 셋팅 값을 다 순회했는지 가드
        guard idx < detailSwRounds.count else {
            detailRoundPhase = .completed
            detailStopState = .completed
            detailDisplay = 0
            updateStopwatchBackgroundColor()
            updateContentState("Completed", 0, 0)
            detailStopCompletion = Date().formatted("yyyy-MM-dd HH:mm:ss")
            return
        }
        
        // 인덱스 증가 -> 다음 타이머 셋팅으로
        detailSwRoundIdx! += 1
        detailRoundPhase = detailSwRounds[idx].currentPhase
        detailDisplay = detailSwRounds[idx].time.totalSeconds
        updateStopwatchBackgroundColor()
        detailStopState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - updateStopPhaseStart
    // 각 루틴 실행 기록 업데이트
    func updateStopPhaseStart(idx: Int) {
        detailSwRounds[idx].startDate = Date().formatted("yyyy-MM-dd HH:mm:ss")
        return
    }
}
