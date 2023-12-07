//
//  WodViewModel+Control.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import Foundation

// MARK: - WodViewModel+SimpleTimer: SimpleTimer Control
extension WodViewModel {
    // MARK: - simpleRestart
    // 재시작
    func simpleRestart() {
        simpleRoundIdx = nil
        simpleTotalTime = simpleRounds.reduce(0) {$0 + ($1.movement + $1.rest) }
        nextSimpleRound()
        return
    }
    
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = simpleRoundIdx else {
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
        guard let roundIdx = simpleRoundIdx, roundIdx >= 0, simpleRoundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        simpleState = .paused
        
        if simpleRoundPhase == .completed {
            simpleRoundIdx! -= 1
            simpleRoundPhase = .movement
            simpleDisplay = simpleRounds[roundIdx-1].movement
            simpleTotalTime = simpleRounds[roundIdx-1].movement
            updateBackgroundColor()
            simpleState = .active
            return
        }
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if simpleRoundPhase == .movement { // 운동인 경우 -> 준비 단계로
                simpleRoundPhase = .preparation
                simpleDisplay = selectedPreparationAmount
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                simpleDisplay = simpleRounds[roundIdx].movement
                simpleRoundPhase = .movement
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
                simpleDisplay = simpleRounds[simpleRoundIdx!].movement
                
            }
        }
        
        updateBeforeSimpleTotalTime()
        updateBackgroundColor()
        simpleState = .active
        return
    }
    
    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let roundIdx = simpleRoundIdx, roundIdx < simpleRounds.count else {
            return
        }
        
        if simpleRoundPhase == .completed {
            updateBackgroundColor()
            return
        }
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if simpleRoundPhase == .preparation { // 준비인 경우 -> 운동 단계로
                simpleRoundPhase = .movement
                simpleDisplay = simpleRounds[roundIdx].movement
                
            } else if simpleRoundPhase == .movement { // 운동 -> 휴식
                let currentRound = simpleRounds[roundIdx]
                simpleRoundPhase = .rest
                simpleDisplay = currentRound.rest
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                simpleRoundIdx! += 1
                let currentRound = simpleRounds[simpleRoundIdx!]
                simpleDisplay = currentRound.movement
                simpleRoundPhase = .movement
            }
        } else {
            if simpleRoundPhase == .movement && roundIdx < simpleRounds.count - 1 { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                let currentRound = simpleRounds[roundIdx]
                simpleRoundPhase = .rest
                simpleDisplay = currentRound.rest
                
                
            } else if simpleRoundPhase == .movement && roundIdx == simpleRounds.count - 1 {
                simpleRoundIdx! += 1
                
            } else { // 휴식인 경우 -> 다음 라운드 운동으로
                simpleRoundIdx! += 1
                let currentRound = simpleRounds[simpleRoundIdx!]
                simpleDisplay = currentRound.movement
                simpleRoundPhase = .movement
            }
        }
        
        updateNextSimpleTotalTime()
        updateBackgroundColor()
        simpleState = .active
        return
    }
    
    // MARK: - updateBeforeSimpleTotalTime
    // 총 시간 업데이트
    private func updateBeforeSimpleTotalTime() {
        guard let idx = simpleRoundIdx, idx < simpleRounds.count else {
            return
        }
        
        simpleTotalTime = 0
        
        var totalBeforeCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            // 운동에서 준비, 휴식에서 운동을 가던 결국 초기 토탈시간으로 가야함
            totalBeforeCurrentRound = simpleRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
            if simpleRoundPhase == .rest {
                totalBeforeCurrentRound -= simpleRounds[idx].movement
            } else {
                totalBeforeCurrentRound += 0
            }
        } else if idx == simpleRounds.count - 1 { // 마지막
            if simpleRoundPhase == .movement { // 운동 -> 전 라운드 휴식
                totalBeforeCurrentRound = simpleRounds[idx].movement + simpleRounds[idx].rest
            } else { // 마지막 라운드엔 휴식 X
                return
            }
        } else { // 중간
            ///    (10 3) - (10 3) - (10 3) - (10 0)
            ///    49 39 - 36 26  -  23 13   10
            /// 49 - 39 36 - 26 23 -  13 10 -  0
            ///
            /// 현재 라운드부터 총 토탈시간 계산해줌
            /// ex) idx = 1일때, totalBeforeCurrentRound = 36
            
            totalBeforeCurrentRound = simpleRounds[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
            
            
            if simpleRoundPhase == .movement { // 운동으로 온경우
                totalBeforeCurrentRound += 0
            } else { // 휴식으로 온 경우
                totalBeforeCurrentRound -= (simpleRounds[idx].movement)
            }
        }
        simpleTotalTime = totalBeforeCurrentRound
        
        return
    }
    
    // MARK: - updateNextSimpleTotalTime
    // 총 시간 업데이트
    private func updateNextSimpleTotalTime() {
        guard let idx = simpleRoundIdx, idx < simpleRounds.count else {
            return
        }
        
        simpleTotalTime = 0
        
        var totalBeforeCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            totalBeforeCurrentRound = simpleRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
            if simpleRoundPhase == .rest {
                totalBeforeCurrentRound -= simpleRounds[idx].movement
            }
        } else if idx == simpleRounds.count - 1 { // 마지막
            if simpleRoundPhase == .movement {
                totalBeforeCurrentRound = simpleRounds[idx].movement
            } else { }
        } else { // 중간
            // 다음 라운드부터 총 토탈시간 계산해줌
            totalBeforeCurrentRound = simpleRounds[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
            
            if simpleRoundPhase == .rest {
                // 휴식에서 다음 라운드로 간 경우
                totalBeforeCurrentRound -= simpleRounds[idx].movement
            } else {
                //totalBeforeCurrentRound -= simpleRounds[idx].rest
            }
        }
        
        simpleTotalTime = totalBeforeCurrentRound
        return
    }
}
