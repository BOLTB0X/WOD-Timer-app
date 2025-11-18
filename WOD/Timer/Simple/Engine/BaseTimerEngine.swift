//
//  BaseTimerEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/10/25.
//

import Combine
import Foundation

// MARK: - BaseTimerEngine
// Base 공통 엔진 (Combine Timer 사용 — 기존 동작 유지)
protocol BaseTimerEngine: AnyObject, PhaseStateHandler {
    var cancellable: AnyCancellable? { get set }
    var display: Int { get set }      // 현재 표시값
    var totalTime: Int { get set }    // 전체 누적/남은 시간
    var phase: SimpleRoundPhase? { get set }

    // 콜백 (consumer가 사용할 용도)
    var onTick: (() -> Void)? { get set }       // 매 tick마다 호출
    var onPhaseCompleted: (() -> Void)? { get set } // phase 완료 시 호출

    func startTicking()
    func stopTicking()
    func playSoundIfNeeded()
    func onTickImpl() // 엔진 개별로 구현
}

extension BaseTimerEngine {
    
    // MARK: - startTicking
    func startTicking() {
        stopTicking()
        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.onTickImpl()
                self.onTick?()
            }
    } // startTicking

    // MARK: - stopTicking
    func stopTicking() {
        cancellable?.cancel()
        cancellable = nil
    } // stopTicking
    
    // MARK: - playSoundIfNeeded
    func playSoundIfNeeded() {
        // 기존 동작 유지: whistle_counting (<=5 && >0), whistle_countComplete (==0)
        if display <= 5 && display > 0 {
            // async/await AVManager 사용 가능하되 호출은 비동기로
            Task {
                try? await AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
            }
        } else if display == 0 {
            Task {
                try? await AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
            }
        }
    } // playSoundIfNeeded

    // MARK: - onTickImpl
    // 기본 onTickImpl는 각 엔진에서 구현
    func onTickImpl() { /* override */ }
}
