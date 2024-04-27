//
//  DetailViewModel+Timer.swift
//  Timer
//
//  Created by lkh on 1/2/24.
//

import Foundation
import Combine

// MARK: - DetailViewModel+Timer: DetailTimer Control
// 제어관련 메소드들
extension DetailViewModel {
    // MARK: - basic Control
    // ....
    // MARK: - startDetailTimer
    func startDetailTimer() {
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            return
        }
        
        print("타이머 실행")
        print(detailRoundPhase?.phaseText ?? "??")
        
        updateTimerPhaseStart(idx: idx)
        
        DispatchQueue.main.async {
            self.speakingCurrentState()
        }
        updateContentState(detailTmRounds[idx].title ?? "Movements", detailTmRounds[idx].currentRound-1, detailDisplay)
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.detailDisplay > 0 && self.detailRoundPhase != .preparation {
                    self.detailRTotalTime -= 1
                }
                
                self.detailDisplay -= 1
                
                self.updateContentState(self.detailTmRounds[idx].title ?? "Movements", self.detailTmRounds[idx].currentRound-1, self.detailDisplay)
                
                // 5초 이하일 때 countdown 사운드 재생
                if self.detailDisplay <= 5 && self.detailDisplay > 0 {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
                    }
                } else if self.detailDisplay == 0 {
                    DispatchQueue.global().async {
                        AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateDetailUnitProgress()
                }
                
                if self.detailDisplay < 0 {
                    self.completedCurrentTimer() // 완료
                }
            } // sink
    }
    
    // MARK: - completedCurrentTimer
    // 현재 타이머 종료시 다음 단계로 이동
    func completedCurrentTimer() {
        timerCancellable?.cancel()
        detailTimerState = .completed
        updateDetailTimerCompletion() // 기록
        detailUnitProgress = 0.0
        // 다음 라운드 페이즈로 이동
        nextTimer()
        return
    }
    
    // MARK: - pauseDetTailimer
    // 일시 중지
    func pauseDetailTimer() {
        timerCancellable?.cancel()
        print("일시중지")
        updateDetailCompletionDate()
        return
    }
    
    // MARK: - resumeDetailTimer
    // 재개
    func resumeDetailTimer() {
        print("재개")
        detailTimerState = .active
        controlBtn = false
        return
    }
    
    // MARK: - detailTimerRestart
    // 재시작
    func detailTimerRestart() {
        detailTmRoundIdx = nil
        detailRTotalTime = detailTmRounds.reduce(0) { $0 + $1.time.totalSeconds }
        detailUnitProgress = 0.0
        nextDetailTimerRound()
        //nextTimer()
        return
    }
    
    // MARK: - detailTimerCanclled
    // 타이머 취소
    func detailTimerCanclled() {
        detailTimerState = .cancelled
        detailTmRoundIdx = nil
        controlBtn = false
        detailUnitProgress = 0
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
        guard let _ = detailTmRoundIdx, detailRoundPhase != .completed else {
            return
        }
        
        controlBtn.toggle()
        
        if detailTimerState == .paused {
            controlBtn = false
            detailTimerState = .resumed
        } else if detailTimerState == .active {
            controlBtn = true
            detailTimerState = .paused
        }
    }
    
    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = detailTmRoundIdx, roundIdx > 0, detailRoundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        detailTimerState = .paused
        detailUnitProgress = 0
        
        // 완료인 경우
        if detailRoundPhase == .completed {
            let current = detailTmRounds[roundIdx]
            detailDisplay = current.time.totalSeconds
            detailRTotalTime = current.time.totalSeconds
            detailRoundPhase = current.currentPhase
        } else {
            detailTmRoundIdx! -= 1
            let current = detailTmRounds[roundIdx - 1]
            detailDisplay = current.time.totalSeconds
            let tmpTime = detailTmRounds[roundIdx...].reduce(0) { $0 + $1.time.totalSeconds }
            
            detailRTotalTime = tmpTime + current.time.totalSeconds
            detailRoundPhase = current.currentPhase
        }
        
        updateTimerBackgroundColor()
        detailTimerState = controlBtn ? .paused : .active
        return
    }
    
    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let roundIdx = detailTmRoundIdx, roundIdx < detailTmRounds.count else {
            return
        }
        
        // 현재 타이머 중지
        detailTimerState = .paused
        detailUnitProgress = 0
        if roundIdx + 1 == detailTmRounds.count {
            detailDisplay = 0
            detailRTotalTime = 0
            detailRoundPhase = .completed
        } else {
            detailTmRoundIdx! += 1
            let current = detailTmRounds[roundIdx + 1]
            detailDisplay = current.time.totalSeconds
            detailRoundPhase = current.currentPhase
            detailRTotalTime = detailTmRounds[(roundIdx + 1)...].reduce(0) { $0 + $1.time.totalSeconds }
        }
        updateTimerBackgroundColor()
        detailTimerState = controlBtn ? .paused : .active
        return
    }
    
    /*==================================================================================*/
    // MARK: - in using
    // ...
    private func speakingCurrentState() {
        guard let phase = detailRoundPhase else { return }
        
        switch phase {
        case .preparation:
            AVManager.shared.playSound(named: "preparation", fileExtension: "caf")
        case .loopMovement:
            AVManager.shared.playSound(named: "movement", fileExtension: "caf")
        case .rest, .loopRest:
            AVManager.shared.playSound(named: "rest", fileExtension: "caf")
        case .completed:
            AVManager.shared.playSound(named: "completed", fileExtension: "caf")
        }
    }
}
