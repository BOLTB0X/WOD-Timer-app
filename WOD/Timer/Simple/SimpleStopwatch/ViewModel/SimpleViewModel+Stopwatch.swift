//
//  SimpleViewModel+StopWatch.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import Foundation
import Combine

// MARK: - SimpleViewModel+StopWatch: SimpleStopWatch Control
// 스톱워치 제어 관련 메소드들
extension SimpleViewModel {
    // MARK: - startSimpleStopWatch
    func startSimpleStopWatch() {
        guard let idx = simpleSwRoundIdx,
                idx < simpleSwRounds.count,
                let currentPhase = simpleRoundPhase else {
            return
        }
//        
////        print("스톱워치 실행")
////        print(simpleRoundPhase?.phaseText ?? "??")
//        
        updateStopPhaseStart(idx: idx, currentPhase: currentPhase)
        updateContentState(currentPhase, idx, simpleDisplay)
        
        engine.configure(rounds: simpleSwRounds, roundIndex: idx, initialPhase: currentPhase, displaySeconds: simpleDisplay, totalTime: simpleTotalTime, mode: .stopwatch)
        engine.start()
//
//        stopwatchEngine.phase = currentPhase
//        stopwatchEngine.display = simpleDisplay
//        stopwatchEngine.totalTime = simpleTotalTime
//
//        stopwatchEngine.startTicking()
////        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
////            .autoconnect()
////            .sink { _ in
////                if self.simpleDisplay >= 0 && self.simpleRoundPhase != .preparation {
////                    self.simpleTotalTime += 1
////                }
////                
////                // 준비일 때만 감소
////                if self.simpleRoundPhase == .preparation {
////                    self.simpleDisplay -= 1
////                    if self.simpleDisplay < 0 {
////                        self.completedCurrentStop()
////                    }
////                } else { // 나머진 그냥 증가
////                    self.simpleDisplay += 1
////                }
////                
////                self.updateContentState(currentPhase, idx, self.simpleDisplay)
////                
////                // 5초 이하이고 준비일 때 countdown 사운드 재생
////                if self.simpleDisplay <= 5 && self.simpleDisplay > 0 && self.simpleRoundPhase == .preparation {
//////                    DispatchQueue.global().async {
//////                        AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
//////                    }
////                } else if self.simpleDisplay == 0 && self.simpleRoundPhase == .preparation {
//////                    DispatchQueue.global().async {
//////                        AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
//////                    }
////                }
////            } // sink
//        
    } // startSimpleStopWatch
    
    // MARK: - completedCurrentStop
    // 현재 타이머 종료시 다음 단계로 이동
    func completedCurrentStop() {
        simpleTimerState = .completed
        nextSimpleStopRoundPhase()
    } // completedCurrentStop
    
    // MARK: - pauseSimpleStop
    // 일시 중지
    func pauseSimpleStop() {
        timerCancellable?.cancel()
        updateSimpleCompletionDate()
    } // pauseSimpleStop
    
    // MARK: - resumeSimpleStop
    // 재개
    func resumeSimpleStop() {
        updateSimpleCompletionDate()
        simpleStopState = .active
        controlBtn = false
    } // resumeSimpleStop
    
    // MARK: - simpleStopRestart
    // 재시작
    func simpleStopRestart() {
        simpleSwRoundIdx = nil
        simpleTotalTime = 0
        nextSimpleTimerRound()
    } // simpleStopRestart
    
    // MARK: - simpleStopCanclled
    // 타이머 취소
    func simpleStopCanclled() {
        simpleTimerState = .cancelled
        simpleSwRoundIdx = nil
        controlBtn = false
        requestOffLiveActivity()
    } // simpleStopCanclled
    
    /*==================================================================================*/
    // MARK: - user Interfase Control
    // ...
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlSwPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = simpleSwRoundIdx, simpleRoundPhase != .completed else {
            return
        }
        
        controlBtn.toggle()
        
        if simpleStopState == .paused {
            controlBtn = false
            simpleStopState = .resumed
        } else if simpleStopState == .active {
            controlBtn = true
            simpleStopState = .paused
        }
    }
    
    // MARK: - controlBack
    // 그 이전으로 되돌아가기
    func controlBack() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = simpleSwRoundIdx, roundIdx >= 0, simpleRoundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        simpleStopState = .paused
        
        if simpleRoundPhase == .completed {
            simpleSwRoundIdx! -= 1
            simpleRoundPhase = .movement
            simpleDisplay = 0
            updateBackgroundColor()
            
            controlBtn = controlBtn
            
            simpleStopState = controlBtn ? .paused : .active
            return
        }
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if simpleRoundPhase == .movement { // 운동인 경우 -> 준비 단계로
                simpleRoundPhase = .preparation
                simpleDisplay = selectedPreparationAmount
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                simpleDisplay = simpleSwRounds[roundIdx].movement
                simpleRoundPhase = .movement
            }
        } else {
            if simpleRoundPhase == .movement { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                simpleSwRoundIdx! -= 1
                let currentRound = simpleSwRounds[simpleSwRoundIdx!]
                simpleRoundPhase = .rest
                simpleDisplay = currentRound.rest
            } else { // 휴식인 경우
                simpleRoundPhase = .movement
                simpleDisplay = simpleSwRounds[simpleSwRoundIdx!].movement
            }
        }
        
        updateBackgroundColor()
        simpleStopState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - controlStopwatchCheck
    // 기록 후 다음으로 가기
    func controlStopwatchCheck() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let roundIdx = simpleSwRoundIdx, roundIdx < simpleSwRounds.count else {
            return
        }
        
        // 현재 타이머 중지
        simpleStopState = .paused
        print("체크")
        
        if simpleRoundPhase == .movement {
            simpleSwRounds[roundIdx].movement = simpleDisplay
            simpleSwRounds[roundIdx].date.movementComplted = simpleDisplay.asTimestamp
        } else if simpleRoundPhase == .rest {
            simpleSwRounds[roundIdx].rest = simpleDisplay
            simpleSwRounds[roundIdx].date.restComplted = simpleDisplay.asTimestamp
        }
        
        nextSimpleStopRoundPhase()
        return
    }
    
}
