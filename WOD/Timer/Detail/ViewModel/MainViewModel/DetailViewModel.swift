//
//  DetailViewModel.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI
import Combine

// MARK: - DetailViewModel
class DetailViewModel: InputManager {
    static let shared = DetailViewModel() // 싱글톤 패턴
    // MARK: - 프로퍼티s
    // ...
    // MARK: - Common
    @Published var detailDisplay: Int = 0
    @Published var detailTotalTime:Int = 0 // 디테일 셋 배열의 총 시간
    @Published var detailRoundPhase: DetailRoundPhase?
    @Published var phaseBackgroundColor: Color = .clear
    @Published var controlBtn: Bool = false // 바인딩할 프로퍼티

    @Published var defaultMove: DetailItem = DetailItem(type: .movement, title: "Movement")
    @Published var defaultRest: DetailItem = DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6)
    @Published var alretMoniter: AlertType = .general
    @Published var multiSelection: Set<UUID> = []
    @Published var betweenRest: Bool = false {
        didSet {
            if betweenRest {
                insertRestBetweenMovements()
            } else {
                removeRestBetweenMovements()
            }
        } // didSet
    }
    
    let detailButtonType: [DetailButton] = [.preparation, .loop, .loopRest, .round]
    var timerCancellable: AnyCancellable? //   // 타이머 메모리 날리기 용

    // ...
    // MARK: - Timer
    @Published var timerPreparationColor: Int  = 15
    @Published var timerLoopRestColor: Int = 8
    @Published var timerLoopList: [DetailItem] = [DetailItem(type: .movement, title: "Movement1"), DetailItem(type: .movement, title: "Movement2")]
    @Published var selectedTimerLoopIndex: Int = 0
    @Published var detailTmRounds: [DetailRound] = [] // 디테일 타이머 배열
    @Published var detailTmRoundIdx: Int? // 진행
    @Published var detailTimerCompletion: String = "X" // 완료일
    @Published var detailUnitProgress: Float = 0.0
    
    // 타이머 상태 관련
    @Published var detailState: TimerState = .cancelled {
        didSet {
            switch detailState {
            case .cancelled, .completed: // 취소 또는 완료
                timerCancellable?.cancel()
                detailDisplay = 0
//                updateSimpleCompletionDate()
            case .active: // 실행
                startDetailTimer()

            case .paused: // 중지
                pauseDetailTimer()

            case .resumed: // 재개
                resumeDetailTimer()

            } // switch
        } // didSet
    }
    
    // ...
    // MARK: - Stopwatch
    @Published var StopCycleList: [DetailItem] = [DetailItem(type: .movement, title: "Movement1"), DetailItem(type: .movement, title: "Movement2")]
    @Published var selectedStopCycleIndex: Int = 0
    @Published var detailSwRounds: [DetailRound] = [] // 디테일 스톱워치 배열
    @Published var detailSwRoundIdx: Int? // 진행
    // ...
}
