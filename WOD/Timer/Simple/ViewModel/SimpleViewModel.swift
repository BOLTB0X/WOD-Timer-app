//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI
import Combine

// MARK: - WodViewModel
class SimpleViewModel: InputManager {
    // MARK: - 프로퍼티s
    static let shared = SimpleViewModel() // 싱글톤 패턴
    
    // MARK: - Publisheds
    // ...
    // 심플 타이머루틴 배열
    @Published var simpleTmRounds: [(movement: Int, rest: Int)] = []
    @Published var simpleTotalTime:Int = 0 // 심플 루틴 배열의 총 시간
    @Published var simpleTmRoundIdx: Int? //
    
    // 심플 스톱워치 루틴 배열
    @Published var simpleSwRounds: [Round] = []  // 심플 루틴 배열
    @Published var simpleSwRoundIdx: Int? //
    
    // etc
    @Published var simpleCompletion: Date? // 완료일
    @Published var simpleDisplay: Int = 0 
//    {
//        didSet {
//            widgetManager.contentState.currentDisplayTime = simpleDisplay
//        }
//    }
    
    // 진행률 -> 타이머
    @Published var simpleUnitProgress: Float = 0.0
    @Published var simpleFullProgress: Float = 0.0

    // MARK: 타이머 상태 관련
    @Published var simpleState: TimerState = .cancelled {
        didSet {
            switch simpleState {
            case .cancelled, .completed: // 취소 또는 완료
                timerCancellable?.cancel()
                simpleDisplay = 0
                updateSimpleCompletionDate()
            case .active: // 실행
                startSimpleTimer()
                
            case .paused: // 중지
                pauseSimpleTimer()
                
            case .resumed: // 재개
                resumeSimpleTimer()
            }
            
            // simpleState가 변경될 때마다 음성 안내
            //UIAccessibility.post(notification: .announcement, argument: simpleRoundPhase?.phaseText ?? "??")
        }
    }
    
    // MARK: 스톱워치 상태 관련
    @Published var simpleStopState: TimerState = .cancelled {
        didSet {
            switch simpleStopState {
            case .cancelled, .completed: // 취소 또는 완료
                timerCancellable?.cancel()
                simpleDisplay = 0
                updateSimpleCompletionDate()
                
            case .active: // 실행
                startSimpleStopWatch()
                
            case .paused: // 중지
                pauseSimpleStop()
                
            case .resumed: // 재개
                resumeSimpleStop()
            }
        }
    }
    
    @Published var simpleRoundPhase: SimpleRoundPhase?
    @Published var phaseBackgroundColor: Color = .clear
    @Published var controlBtn: Bool = false // 바인딩할 프로퍼티
    
    @Published var widgetManager = WidgetManager()

    var timerCancellable: AnyCancellable? //   // 타이머 메모리 날리기 용
    let simpleButtonType: [SimpleButton] = [.round, .preparation, .movements, .rest]
}
