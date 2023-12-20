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
        guard let idx = simpleSwRoundIdx, idx < simpleSwRounds.count else {
            return
        }
        
        print("스톱워치 실행")
        print(simpleRoundPhase?.phaseText ?? "??")
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.simpleDisplay >= 0 && self.simpleRoundPhase != .preparation {
                    self.simpleTotalTime += 1
                }
                
                // 준비일 때만 감소
                if self.simpleRoundPhase == .preparation {
                    self.simpleDisplay -= 1
                } else { // 나머진 그냥 증가
                    self.simpleDisplay += 1
                }
                
                // 5초 이하이고 준비일 때 countdown 사운드 재생
                if self.simpleDisplay <= 5 && self.simpleDisplay > 0 && self.simpleRoundPhase == .preparation {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
                    }
                } else if self.simpleDisplay == 0 {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
                    }
                }
            } // sink
    } // startSimpleStopWatch
    
    // MARK: - completedCurrentStop
    // 현재 타이머 종료시 다음 단계로 이동
    func completedCurrentStop() {
        timerCancellable?.cancel()
        simpleState = .completed
        // 다음 라운드 페이즈로 이동
        nextSimpleStopRoundPhase()
        return
    }
    
    // MARK: - pauseSimpleStop
    // 일시 중지
    func pauseSimpleStop() {
        timerCancellable?.cancel()
        print("일시중지")
        updateSimpleCompletionDate()
        return
    }
    
    // MARK: - resumeSimpleStop
    // 재개
    func resumeSimpleStop() {
        print("재개")
        updateSimpleCompletionDate()
        simpleState = .active
        controlBtn = false
        return
    }
    
    // MARK: - simpleStopRestart
    // 재시작
    func simpleStopRestart() {
        simpleSwRoundIdx = nil
        simpleTotalTime = 0
        nextSimpleTimerRound()
        return
    }
    
    // MARK: - simpleStopCanclled
    // 타이머 취소
    func simpleStopCanclled() {
        simpleState = .cancelled
        simpleSwRoundIdx = nil
        controlBtn = false
        return
    }
    
    /*==================================================================================*/
    // MARK: - user Interfase Control
    // ...
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlSwPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
    }
}
