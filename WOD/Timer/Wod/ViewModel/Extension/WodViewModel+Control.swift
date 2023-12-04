//
//  WodViewModel+Control.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import Foundation

// MARK: - WodViewModel+SimpleTimer: SimpleTimer Control
extension WodViewModel {
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = simpleRoundIdx, simpleState != .completed else {
            return
        }
        
        if simpleState == .paused {
            simpleState = .resumed
        } else { simpleState = .paused }
        return
    }
    
    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = simpleRoundIdx, roundIdx >= 0, simpleRoundPhase == .preparation else {
            return
        }
        
        // 현재 타이머 중지
        simpleState = .paused
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if simpleRoundPhase == .movement { // 운동인 경우 -> 준비 단계로
                simpleRoundPhase = .preparation
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                simpleRoundPhase = .movement
                simpleDisplay = simpleRounds[roundIdx].movement
            }
        } else {
            if simpleRoundPhase == .movement { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                simpleRoundIdx! -= 1
                let currentRound = simpleRounds[simpleRoundIdx!]
                simpleRoundPhase = .rest
                simpleDisplay = currentRound.rest
                
            } else { // 휴식인 경우
                simpleRoundPhase = .movement
                simpleDisplay = simpleRounds[roundIdx].movement
            }
        }
        
        updateBackgroundColor()
        simpleState = .active
        updateSimpleTotalTime()

        return
    }
    
    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        
    }
    
    // MARK: - updateSimpleTotalTime
    // 총 시간 업데이트
    private func updateSimpleTotalTime() {
        guard let idx = simpleRoundIdx else {
            return
        }
        
        // 초기화
        simpleTotalTime = 0
        
        // 현재 라운드까지의 총 시간을 더함
        for i in 0...idx {
            simpleTotalTime += (simpleRounds[i].movement + simpleRounds[i].rest)
        }
        return
    }
    
    
}
