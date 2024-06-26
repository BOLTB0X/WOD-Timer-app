//
//  WodViewModel+Control.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import Foundation
import Combine
import ActivityKit

// MARK: - SimpleViewModel+Timer: SimpleTimer Control
// 제어관련 메소드들
extension SimpleViewModel {
    // MARK: - basic Control
    // ....
    // MARK: - startSimpleTimer
    func startSimpleTimer() {
        guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count, let currentPhase = simpleRoundPhase else {
            return
        }
        
        print("타이머 실행")
        print(simpleRoundPhase?.phaseText ?? "??")
        
        updateTimerPhaseStart(idx: idx, currentPhase: currentPhase)
        
        DispatchQueue.main.async {
            self.speakingCurrentState()
        }
        
        updateContentState(currentPhase, idx, simpleDisplay)
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.simpleDisplay > 0 && self.simpleRoundPhase != .preparation {
                    self.simpleTotalTime -= 1
                }
                
                self.simpleDisplay -= 1
                
                self.updateContentState(currentPhase, idx, self.simpleDisplay)
                
                // 5초 이하일 때 countdown 사운드 재생
                if self.simpleDisplay <= 5 && self.simpleDisplay > 0 {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
                    }
                } else if self.simpleDisplay == 0 {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateSimpleUnitProgress()
                }
                
                if self.simpleDisplay < 0 {
                    self.completedCurrentTimer() // 완료
                }
                
            } // sink
        
        return
    }
    
    // MARK: - completedCurrentTimer
    // 현재 타이머 종료시 다음 단계로 이동
    func completedCurrentTimer() {
        timerCancellable?.cancel()
        simpleTimerState = .completed
        updateSimpleTimerCompletion() // 기록
        simpleUnitProgress = 0.0
        // 다음 라운드 페이즈로 이동
        nextSimpleTimerRoundPhase()
        return
    }
    
    // MARK: - pauseSimpleTimer
    // 일시 중지
    func pauseSimpleTimer() {
        timerCancellable?.cancel()
        print("일시중지")
        updateSimpleCompletionDate()
        return
    }
    
    // MARK: - resumeSimpleTimer
    // 재개
    func resumeSimpleTimer() {
        print("재개")
        updateSimpleCompletionDate()
        simpleTimerState = .active
        controlBtn = false
        return
    }
    
    // MARK: - simpleTimerRestart
    // 재시작
    func simpleTimerRestart() {
        simpleTmRoundIdx = nil
        simpleTotalTime = simpleTmRounds.reduce(0) {$0 + ($1.movement + $1.rest) }
        nextSimpleTimerRound()
        return
    }
    
    // MARK: - simpleTimerCanclled
    // 타이머 취소
    func simpleTimerCanclled() {
        simpleTimerState = .cancelled
        simpleTmRoundIdx = nil
        controlBtn = false
        simpleUnitProgress = 0
        requestOffLiveActivity()
        return
    }
    
    /*==================================================================================*/
    // MARK: - user Interfase Control
    // ...
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlTmPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = simpleTmRoundIdx, simpleRoundPhase != .completed else {
            return
        }
        
        controlBtn.toggle()
        
        if simpleTimerState == .paused {
            controlBtn = false
            simpleTimerState = .resumed
        } else if simpleTimerState == .active {
            controlBtn = true
            simpleTimerState = .paused
        }
    }
    
    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = simpleTmRoundIdx, roundIdx >= 0, simpleRoundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        simpleTimerState = .paused
        simpleUnitProgress = 0
        
        if simpleRoundPhase == .completed {
            simpleTmRoundIdx! -= 1
            simpleRoundPhase = .movement
            simpleDisplay = simpleTmRounds[roundIdx-1].movement
            simpleTotalTime = simpleTmRounds[roundIdx-1].movement
            updateBackgroundColor()
            
            controlBtn = controlBtn
            
            simpleTimerState = controlBtn ? .paused : .active
            return
        }
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if simpleRoundPhase == .movement { // 운동인 경우 -> 준비 단계로
                simpleRoundPhase = .preparation
                simpleDisplay = selectedPreparationAmount
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                simpleDisplay = simpleTmRounds[roundIdx].movement
                simpleRoundPhase = .movement
            }
        } else {
            if simpleRoundPhase == .movement { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                simpleTmRoundIdx! -= 1
                let currentRound = simpleTmRounds[simpleTmRoundIdx!]
                simpleRoundPhase = .rest
                simpleDisplay = currentRound.rest
            } else { // 휴식인 경우
                simpleRoundPhase = .movement
                simpleDisplay = simpleTmRounds[simpleTmRoundIdx!].movement
            }
        }
        
        updateBeforeSimpleTotalTime()
        updateBackgroundColor()
        simpleTimerState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let roundIdx = simpleTmRoundIdx, roundIdx < simpleTmRounds.count else {
            return
        }
        
        // 현재 타이머 중지
        simpleTimerState = .paused
        simpleUnitProgress = 0
        nextSimpleTimerRoundPhase()
        updateNextSimpleTotalTime()
        return
    }
    
    /*==================================================================================*/
    // MARK: - in using
    // ...
    private func speakingCurrentState() {
        guard let phase = simpleRoundPhase else { return }
        
        switch phase {
        case .preparation:
            AVManager.shared.playSound(named: "preparation", fileExtension: "caf")
        case .movement:
            AVManager.shared.playSound(named: "movement", fileExtension: "caf")
        case .rest:
            AVManager.shared.playSound(named: "rest", fileExtension: "caf")
        case .completed:
            AVManager.shared.playSound(named: "completed", fileExtension: "caf")
        }
    }
    
    // MARK: - updateBeforeSimpleTotalTime
    // 총 시간 업데이트
    private func updateBeforeSimpleTotalTime() {
        guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count else {
            return
        }
        
        simpleTotalTime = 0
        
        var totalBeforeCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            // 운동에서 준비, 휴식에서 운동을 가던 결국 초기 토탈시간으로 가야함
            totalBeforeCurrentRound = simpleTmRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
            if simpleRoundPhase == .rest {
                totalBeforeCurrentRound -= simpleTmRounds[idx].movement
            } else {
                totalBeforeCurrentRound += 0
            }
        } else if idx == simpleTmRounds.count - 1 { // 마지막
            if simpleRoundPhase == .movement { // 운동 -> 전 라운드 휴식
                totalBeforeCurrentRound = simpleTmRounds[idx].movement + simpleTmRounds[idx].rest
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
            
            totalBeforeCurrentRound = simpleTmRounds[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
            
            if simpleRoundPhase == .movement { // 운동으로 온경우
                totalBeforeCurrentRound += 0
            } else { // 휴식으로 온 경우
                totalBeforeCurrentRound -= (simpleTmRounds[idx].movement)
            }
        }
        simpleTotalTime = totalBeforeCurrentRound
        
        return
    }
    
    // MARK: - updateNextSimpleTotalTime
    // 총 시간 업데이트
    private func updateNextSimpleTotalTime() {
        guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count else {
            simpleTotalTime = 0
            return
        }
        
        simpleTotalTime = 0
        
        var totalNextCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            totalNextCurrentRound = simpleTmRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
            if simpleRoundPhase == .rest {
                totalNextCurrentRound -= simpleTmRounds[idx].movement
            } else {
            }
        } else if idx == simpleTmRounds.count - 1 { // 마지막
            if simpleRoundPhase == .movement {
                totalNextCurrentRound = simpleTmRounds[idx].movement
            } else {
                totalNextCurrentRound = 0
            }
        } else { // 중간
            // 다음 라운드부터 총 토탈시간 계산해줌
            totalNextCurrentRound = simpleTmRounds[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
            
            if simpleRoundPhase == .rest {
                // 휴식에서 다음 라운드로 간 경우
                totalNextCurrentRound -= simpleTmRounds[idx].movement
            } else {
            }
        }
        
        simpleTotalTime = totalNextCurrentRound
        return
    }
}
