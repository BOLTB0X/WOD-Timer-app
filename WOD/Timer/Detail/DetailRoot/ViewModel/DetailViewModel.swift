//
//  DetailViewModel.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI
import Combine
import ActivityKit

// MARK: - DetailViewModel
class DetailViewModel: InputManager {
    static let shared = DetailViewModel() // 싱글톤 패턴
    // MARK: - 프로퍼티s
    // ...
    // MARK: - Common
    @Published var detailCompletion: Date? // 완료일
    @Published var detailDisplay: Int = 0
    @Published var detailRTotalTime:Int = 0 // 디테일 셋 배열의 총 시간
    @Published var detailSTotalTime:Int = 0 // 디테일 셋 배열의 총 시간
    @Published var detailRoundPhase: DetailRoundPhase?
    @Published var phaseBackgroundColor: Color = .clear
    @Published var controlBtn: Bool = false // 바인딩할 프로퍼티

    @Published var defaultMove: DetailItem = DetailItem(type: .movement, title: "Movement")
    @Published var defaultRest: DetailItem = DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6)
    @Published var alretMoniter: AlertType = .general
    @Published var multiSelection: Set<UUID> = []
    @Published var detailUnitProgress: Float = 0.0
    
    let detailButtonType: [DetailButton] = [.preparation, .loop, .loopRest, .round]
    var timerCancellable: AnyCancellable? //   // 타이머 메모리 날리기 용

    // ...
    // MARK: - Timer
    @Published var timerPreparationColor: Int  = 15
    @Published var timerRestColor: Int = 8
    @Published var timerLoopList: [DetailItem] = [DetailItem(type: .movement, title: "Movement1"), DetailItem(type: .movement, title: "Movement2")]
    @Published var selectedTimerLoopIndex: Int = 0
    @Published var detailTmRounds: [DetailTmRound] = [] // 디테일 타이머 배열
    @Published var detailTmRoundIdx: Int? // 진행
    @Published var detailTimerCompletion: String = "X" // 완료일
    @Published var betweenRestInTimer: Bool = false {
        didSet {
            if betweenRestInTimer {
                insertRestBetweenMovementsInTimer()
            } else {
                removeRestBetweenMovementsInTimer()
            }
        } // didSet
    }
    
    // 타이머 상태 관련
    @Published var detailTimerState: TimerState = .cancelled {
        didSet {
            switch detailTimerState {
            case .cancelled, .completed: // 취소 또는 완료
                timerCancellable?.cancel()
                detailDisplay = 0
                updateDetailCompletionDate()
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
    @Published var stopPreparationColor: Int  = 15
    @Published var stopRestColor: Int = 8
    @Published var stopLoopList: [DetailItem] = [DetailItem(type: .movement, title: "Movement1", time: MovementTime(seconds: 0)), DetailItem(type: .movement, title: "Movement2", time: MovementTime(seconds: 0))]
    @Published var selectedStopLoopIndex: Int = 0
    @Published var detailSwRounds: [DetailTmRound] = [] // 디테일 스톱워치 배열
    @Published var detailSwRoundIdx: Int? // 진행
    @Published var detailStopCompletion: String = "X" // 완료일

    @Published var betweenRestInStop: Bool = false {
        didSet {
            if betweenRestInStop {
                insertRestBetweenMovementsInStop()
            } else {
                removeRestBetweenMovementsInStop()
            }
        } // didSet
    }
    
    // 스톱워치 상태 관련
    @Published var detailStopState: TimerState = .cancelled {
        didSet {
            switch detailStopState {
            case .cancelled, .completed: // 취소 또는 완료
                timerCancellable?.cancel()
                detailDisplay = 0
                updateDetailCompletionDate()
            case .active: // 실행
                startDetailStopwatch()

            case .paused: // 중지
                pauseDetailStop()

            case .resumed: // 재개
                resumeDetailStop()

            } // switch
        } // didSet
    }
    // ...
    
    var activity: Activity<TimerWidgetAttributes>? // 라이브 액티비티
}
