//
//  DetailViewModel+Stopwatch.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import Foundation
import Combine

// MARK: - DetailViewModel+Timer: DetailTimer Control
// 제어관련 메소드들
extension DetailViewModel {
    // MARK: - basic Control
    // ....
    // MARK: - startDetailStopwatch
    func startDetailStopwatch() {
        guard let idx = detailSwRoundIdx, idx < detailSwRounds.count else {
            print("비어있음")
            return
        }
        
        print("타이머 실행")
        print(detailRoundPhase?.phaseText ?? "??")
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.detailDisplay >= 0 && self.detailRoundPhase != .preparation {
                    self.detailSTotalTime += 1
                }
                
                // 준비일 때만 감소
                if self.detailRoundPhase == .preparation {
                    self.detailDisplay -= 1
                    if self.detailDisplay < 0 {
                        self.completedCurrentStop()
                    }
                } else { // 나머진 그냥 증가
                    self.detailDisplay += 1
                }
                // 5초 이하이고 준비일 때 countdown 사운드 재생
                if self.detailDisplay <= 5 && self.detailDisplay > 0 && self.detailRoundPhase == .preparation {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
                    }
                } else if self.detailDisplay == 0 && self.detailRoundPhase == .preparation {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateDetailUnitProgress()
                }
                
//                if self.detailDisplay < 0 {
//                    self.completedCurrentTimer() // 완료
//                }
            } // sink
    } // startDetailStopwatch
    
    // MARK: - completedCurrentStop
    // 현재 타이머 종료시 다음 단계로 이동
    func completedCurrentStop() {
        timerCancellable?.cancel()
        detailStopState = .completed
        // 다음 라운드 페이즈로 이동
        nextDetailStopRound()
        updateDetailStopCompletion()
        return
    }
    
    // MARK: - pauseDetailStop
    // 일시 중지
    func pauseDetailStop() {
        timerCancellable?.cancel()
        print("일시중지")
        updateDetailStopHistory(state: "pause")
        return
    }
    
    // MARK: - resumeDetailStop
    // 재개
    func resumeDetailStop() {
        print("재개")
        updateDetailStopHistory(state: "resume")
        detailStopState = .active
        controlBtn = false
        return
    }
    
    // MARK: - detailStopRestart
    // 재시작
    func detailStopRestart() {
        detailSwRoundIdx = nil
        detailSTotalTime = 0
        nextDetailStopRound()
        return
    }
    
    // MARK: - detailStopCanclled
    // 타이머 취소
    func detailStopCanclled() {
        detailStopState = .cancelled
        detailSwRoundIdx = nil
        controlBtn = false
        return
    }
    
    /*==================================================================================*/
    // MARK: - user Interfase Control
    // ...
    // MARK: - controlBack
    func controlBack() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = detailSwRoundIdx, roundIdx > 0, detailRoundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        detailStopState = .paused
        //detailUnitProgress = 0
        
        // 완료인 경우
        if detailRoundPhase == .completed {
            let current = detailSwRounds[roundIdx]
            detailDisplay = current.time.totalSeconds
            detailRoundPhase = current.currentPhase
        } else {
            detailSwRoundIdx! -= 1
            let current = detailSwRounds[roundIdx - 1]
            detailDisplay = current.time.totalSeconds
            detailRoundPhase = current.currentPhase
        }
        
        updateStopwatchBackgroundColor()
        detailStopState = controlBtn ? .paused : .active
        return
    }
    
    
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlSwPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = detailSwRoundIdx, detailRoundPhase != .completed else {
            return
        }
        
        controlBtn.toggle()
        
        if detailStopState == .paused {
            controlBtn = false
            detailStopState = .resumed
        } else if detailStopState == .active {
            controlBtn = true
            detailStopState = .paused
        }
    }
    
    
    // MARK: - controlStopwatchCheck
    // 기록 후 다음으로 가기
    func controlStopwatchCheck() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let idx = detailSwRoundIdx, idx < detailSwRounds.count else {
            return
        }
        
        // 현재 타이머 중지
        detailStopState = .paused
        print("체크")
        
        detailSwRounds[idx].time = MovementTime(seconds: detailDisplay)
        detailSwRounds[idx].endDate = Date().formatted("yyyy-MM-dd HH:mm:ss")
        nextDetailStopRound()
        return
    }
}
