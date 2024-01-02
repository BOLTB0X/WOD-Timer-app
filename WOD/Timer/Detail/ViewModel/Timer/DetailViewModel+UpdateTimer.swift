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
//                detailTmRounds.append(SimpleRound(movement: selectedMovementAmount.totalSeconds, rest: 0, date: StartComplted()))
            } else {
//                simpleTmRounds.append(SimpleRound(movement: selectedMovementAmount.totalSeconds, rest: selectedRestAmount.totalSeconds, date: StartComplted()))
            }
        } // for
        
//        simpleTotalTime = simpleTmRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
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
