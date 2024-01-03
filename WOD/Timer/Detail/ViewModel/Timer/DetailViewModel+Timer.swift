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
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count, let currentPhase = detailRoundPhase else {
            return
        }
        
        print("타이머 실행")
        print(detailRoundPhase?.phaseText ?? "??")
        
        //updateTimerPhaseStart(idx: idx, currentPhase: currentPhase)
        
//        DispatchQueue.main.async {
//            self.speakingCurrentState()
//        }
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.detailDisplay > 0 && self.detailRoundPhase != .preparation {
                    self.detailTotalTime -= 1
                }
                
                self.detailDisplay -= 1
                
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
        detailState = .completed
        //updateSimpleTimerCompletion() // 기록
        detailUnitProgress = 0.0
        // 다음 라운드 페이즈로 이동
        //nextSimpleTimerRoundPhase()
        return
    }
    
    // MARK: - pauseDetTailimer
    // 일시 중지
    func pauseDetailTimer() {
        timerCancellable?.cancel()
        print("일시중지")
        //updateSimpleCompletionDate()
        return
    }
    
    // MARK: - resumeDetailTimer
    // 재개
    func resumeDetailTimer() {
        print("재개")
        //updateSimpleCompletionDate()
        detailState = .active
        controlBtn = false
        return
    }
    
    // MARK: - detailTimerRestart
    // 재시작
    func detailTimerRestart() {
        detailTmRoundIdx = nil
        detailTotalTime = detailTmRounds.reduce(0) { $0 + ($1.totalMovementTime + $1.loopRest) }
        //nextSimpleTimerRound()
        return
    }
    
    // MARK: - detailTimerCanclled
    // 타이머 취소
    func detailTimerCanclled() {
        detailState = .cancelled
        detailTmRoundIdx = nil
        controlBtn = false
        detailUnitProgress = 0
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
        
        if detailState == .paused {
            controlBtn = false
            detailState = .resumed
        } else if detailState == .active {
            controlBtn = true
            detailState = .paused
        }
    }
    
    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = detailTmRoundIdx, roundIdx >= 0, detailRoundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        detailState = .paused
        detailUnitProgress = 0
        
        if detailRoundPhase == .completed {
            detailTmRoundIdx! -= 1
            detailRoundPhase = .movement
//            detailDisplay = detailTmRounds[roundIdx-1].movement
//            detailTotalTime = detailTmRounds[roundIdx-1].movement
//            updateBackgroundColor()
            
            controlBtn = controlBtn
            
            detailState = controlBtn ? .paused : .active
            return
        }
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if detailRoundPhase == .movement { // 운동인 경우 -> 준비 단계로
                detailRoundPhase = .preparation
                detailDisplay = selectedPreparationAmount
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                //detailDisplay = simpleTmRounds[roundIdx].movement
                detailRoundPhase = .movement
            }
        } else {
            if detailRoundPhase == .movement { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                detailTmRoundIdx! -= 1
                let currentRound = detailTmRounds[detailTmRoundIdx!]
                detailRoundPhase = .rest
                //detailDisplay = currentRound.rest
            } else { // 휴식인 경우
                detailRoundPhase = .movement
                //detailDisplay = simpleTmRounds[simpleTmRoundIdx!].movement
            }
        }
        
        //updateBeforeSimpleTotalTime()
        //updateBackgroundColor()
        detailState = controlBtn ? .paused : .active
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
        detailState = .paused
        detailUnitProgress = 0
//        nextSimpleTimerRoundPhase()
//        updateNextSimpleTotalTime()
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
        case .movement:
            AVManager.shared.playSound(named: "movement", fileExtension: "caf")
        case .rest:
            AVManager.shared.playSound(named: "rest", fileExtension: "caf")
        case .completed:
            AVManager.shared.playSound(named: "completed", fileExtension: "caf")
        }
    }
    
    // MARK: - updateBeforeDetailTotalTime
    // 총 시간 업데이트
    private func updateBeforeDetailTotalTime() {
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            return
        }
        
        detailTotalTime = 0
        
        var totalBeforeCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            // 운동에서 준비, 휴식에서 운동을 가던 결국 초기 토탈시간으로 가야함
//            totalBeforeCurrentRound = simpleTmRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
//            if simpleRoundPhase == .rest {
//                totalBeforeCurrentRound -= simpleTmRounds[idx].movement
//            } else {
//                totalBeforeCurrentRound += 0
            //}
        } else if idx == detailTmRounds.count - 1 { // 마지막
//            if simpleRoundPhase == .movement { // 운동 -> 전 라운드 휴식
//                totalBeforeCurrentRound = simpleTmRounds[idx].movement + simpleTmRounds[idx].rest
//            } else { // 마지막 라운드엔 휴식 X
//                return
//            }
        } else { // 중간
            ///    (10 3) - (10 3) - (10 3) - (10 0)
            ///    49 39 - 36 26  -  23 13   10
            /// 49 - 39 36 - 26 23 -  13 10 -  0
            ///
            /// 현재 라운드부터 총 토탈시간 계산해줌
            /// ex) idx = 1일때, totalBeforeCurrentRound = 36
            
//            totalBeforeCurrentRound = simpleTmRounds[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
//            
//            if simpleRoundPhase == .movement { // 운동으로 온경우
//                totalBeforeCurrentRound += 0
//            } else { // 휴식으로 온 경우
//                totalBeforeCurrentRound -= (simpleTmRounds[idx].movement)
//            }
        }
        detailTotalTime = totalBeforeCurrentRound
        
        return
    }
    
    // MARK: - updateNextDetailTotalTime
    // 총 시간 업데이트
    private func updateNextDetailTotalTime() {
        guard let idx = detailTmRoundIdx, idx < detailTmRounds.count else {
            detailTotalTime = 0
            return
        }
        
        detailTotalTime = 0
        
        var totalNextCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
//            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
//            totalNextCurrentRound = simpleTmRounds.reduce(0) { $0 + ($1.movement + $1.rest) }
//            if simpleRoundPhase == .rest {
//                totalNextCurrentRound -= simpleTmRounds[idx].movement
//            } else {
//            }
        } else if idx == detailTmRounds.count - 1 { // 마지막
//            if simpleRoundPhase == .movement {
//                totalNextCurrentRound = simpleTmRounds[idx].movement
//            } else {
//                totalNextCurrentRound = 0
//            }
        } else { // 중간
//            // 다음 라운드부터 총 토탈시간 계산해줌
//            totalNextCurrentRound = simpleTmRounds[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
//            
//            if simpleRoundPhase == .rest {
//                // 휴식에서 다음 라운드로 간 경우
//                totalNextCurrentRound -= simpleTmRounds[idx].movement
//            } else {
//            }
        }
        
        detailTotalTime = totalNextCurrentRound
        return
    }
}
