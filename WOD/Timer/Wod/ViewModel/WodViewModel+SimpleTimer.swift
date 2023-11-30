//
//  WodViewModel+SimpleTimer.swift
//  Timer
//
//  Created by lkh on 11/27/23.
//

import Foundation
import Combine

// MARK: - WodViewModel+SimpleTimer
extension WodViewModel {
    // MARK: - SimpleTimer Methods
    
    // MARK: - simpleStartTouched
    // 스타트 신호를 받으면 타이머을 돌린 배열에 넣어줌
    func simpleStartTouched() {
        for i in 0..<selectedRoundAmount {
            if i == selectedRoundAmount - 1 {
                simpleRounds.append((selectedPreparationAmount, selectedMovementAmount.totalSeconds, 0))
            } else {
                simpleRounds.append((selectedPreparationAmount, selectedMovementAmount.totalSeconds, selectedRestAmount.totalSeconds))
            }
        }
        
        simpleTotalTime = simpleRounds.map { $0.0 + $0.1 + $0.2 }.reduce(0, +)
        print(simpleRounds, simpleTotalTime)
        return
    }
    
    // MARK: - moveToNextRound
    // 다음 라운드로 이동
    func moveToNextRound() {
        if simpleRoundIdx == nil {
            simpleRoundIdx = 0
        } else {
            simpleRoundIdx! += 1
        }
        
        guard simpleRoundIdx! < simpleRounds.count else {
            simpleRoundPhase = .completed
            print("완료")
            return
        }
        
        let currentRound = simpleRounds[simpleRoundIdx!]
        simpleDisplay = currentRound.0
        simpleRoundPhase = .preparation
        print(simpleRoundPhase?.phaseText ?? "")
        simpleState = .active
        return
    }
    
    // MARK: - moveToNextRoundPhase
    // 라운드의 다음 단계로 이동
    func moveToNextRoundPhase() {
        guard let currentPhase = simpleRoundPhase else { return }
        let currentRound = simpleRounds[simpleRoundIdx!]
        
        switch currentPhase {
        case .preparation:
//            let currentRound = simpleRounds[simpleRoundIdx!]
            simpleDisplay = currentRound.1
            simpleRoundPhase = .movement
            simpleState = .active
            
        case .movement:
//            let currentRound = simpleRounds[simpleRoundIdx!]
            if simpleRoundIdx! < selectedRoundAmount - 1 {
                simpleDisplay = currentRound.2
            }
            simpleRoundPhase = .rest
            simpleState = .active
            
        case .rest:
            // 현재 라운드의 모든 단계가 완료된 경우 다음 라운드로 이동
            moveToNextRound()
            
        default:
            break
        }
    }
}
