//
//  RoundPhase.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/21/25.
//

import Foundation

// MARK: - RoundPhase
protocol SimpleControl: AnyObject {
    var roundIndex: Int? { get set }
    var roundArray: [SimpleRound] { get }
    var roundTotalTime: Int { get set }
    var roundPhase: SimpleRoundPhase? { get set }
    var displayTime: Int { get set }
    var engineState: TimerState { get set }
    var controlBtn: Bool { get set }
    var unitProgress: Float { get set }
    
    func updateBackgroundColor()
    
    var selectedPreparationAmount: Int { get }
    var selectedMovementAmount: Int { get }
    var selectedRestAmount: Int { get }
} // RoundPhase

// MARK: - impl
extension SimpleControl {
    
    // MARK: - controlPausedOrResumed
    func controlPausedOrResumed() {
        guard let _ = roundIndex,
              roundPhase != .completed
        else {
            return
        }
        
        controlBtn.toggle()
        
        if engineState == .paused {
            controlBtn = false
            engineState = .resumed
        } else if engineState == .active {
            controlBtn = true
            engineState = .paused
        }
    } // controlPausedOrResumed
    
    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = roundIndex, roundIdx >= 0, roundPhase != .preparation else {
            return
        }
        
        // 현재 타이머 중지
        engineState = .paused
        unitProgress = 0
        
        if roundPhase == .completed {
            roundIndex! -= 1
            roundPhase = .movement
            displayTime = roundArray[roundIdx-1].movement
            roundTotalTime = roundArray[roundIdx-1].movement
            updateBackgroundColor()
            
            controlBtn = controlBtn
            
            engineState = controlBtn ? .paused : .active
            return
        }
        
        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if roundPhase == .movement { // 운동인 경우 -> 준비 단계로
                roundPhase = .preparation
                displayTime = selectedPreparationAmount
                
            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                displayTime = roundArray[roundIdx].movement
                roundPhase = .movement
            }
        } else {
            if roundPhase == .movement { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                roundIndex! -= 1
                let currentRound = roundArray[roundIndex!]
                roundPhase = .rest
                displayTime = currentRound.rest
            } else { // 휴식인 경우
                roundPhase = .movement
                displayTime = roundArray[roundIndex!].movement
            }
        } // if - else
        
        updateBeforeTotalTime()
        updateBackgroundColor()
        engineState = controlBtn ? .paused : .active
        return
    } // controlBefore
    
    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let roundIdx = roundIndex, roundIdx < roundArray.count else {
            return
        }
        
        // 현재 타이머 중지
        engineState = .paused
        unitProgress = 0
        //nextSimpleTimerRoundPhase()
        updateNextTotalTime()
        return
    }
    
    // MARK: - updateBeforeTotalTime
    private func updateBeforeTotalTime() {
        guard let idx = roundIndex, idx < roundArray.count else {
            return
        }
        
        roundTotalTime = 0
        
        var totalBeforeCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            // 운동에서 준비, 휴식에서 운동을 가던 결국 초기 토탈시간으로 가야함
            totalBeforeCurrentRound = roundArray.reduce(0) { $0 + ($1.movement + $1.rest) }
            if roundPhase == .rest {
                totalBeforeCurrentRound -= roundArray[idx].movement
            } else {
                totalBeforeCurrentRound += 0
            }
        } else if idx == roundArray.count - 1 { // 마지막
            if roundPhase == .movement { // 운동 -> 전 라운드 휴식
                totalBeforeCurrentRound = roundArray[idx].movement + roundArray[idx].rest
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
            
            totalBeforeCurrentRound = roundArray[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
            
            if roundPhase == .movement { // 운동으로 온경우
                totalBeforeCurrentRound += 0
            } else { // 휴식으로 온 경우
                totalBeforeCurrentRound -= (roundArray[idx].movement)
            }
        }
        roundTotalTime = totalBeforeCurrentRound
        
        return
    } // updateBeforeTotalTime
    
    // MARK: - updateNextSimpleTotalTime
    // 총 시간 업데이트
    private func updateNextTotalTime() {
        guard let idx = roundIndex, idx < roundArray.count else {
            roundTotalTime = 0
            return
        }
        
        roundTotalTime = 0
        
        var totalNextCurrentRound: Int = 0
        
        if idx == 0 { // 맨 처음
            // 0번째 라운드에서는 초기 설정값으로 토탈시간 설정
            totalNextCurrentRound = roundArray.reduce(0) { $0 + ($1.movement + $1.rest) }
            if roundPhase == .rest {
                totalNextCurrentRound -= roundArray[idx].movement
            } else {
            }
        } else if idx == roundArray.count - 1 { // 마지막
            if roundPhase == .movement {
                totalNextCurrentRound = roundArray[idx].movement
            } else {
                totalNextCurrentRound = 0
            }
        } else { // 중간
            // 다음 라운드부터 총 토탈시간 계산해줌
            totalNextCurrentRound = roundArray[idx...].reduce(0) { $0 + ($1.movement + $1.rest) }
            
            if roundPhase == .rest {
                // 휴식에서 다음 라운드로 간 경우
                totalNextCurrentRound -= roundArray[idx].movement
            } else {
            }
        }
        
        roundTotalTime = totalNextCurrentRound
        return
    }
    
    // MARK: - speakingCurrentState
    private func speakingCurrentState() {
        guard let phase = roundPhase else { return }
        
//        switch phase {
//        case .preparation:
//            AVManager.shared.playSound(named: "preparation", fileExtension: "caf")
//        case .movement:
//            AVManager.shared.playSound(named: "movement", fileExtension: "caf")
//        case .rest:
//            AVManager.shared.playSound(named: "rest", fileExtension: "caf")
//        case .completed:
//            AVManager.shared.playSound(named: "completed", fileExtension: "caf")
//        }
    } // speakingCurrentState
} // impl
