//
//  WodViewModel.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI
import Combine

// MARK: - WodViewModel
class WodViewModel: InputManager {
    // MARK: - 프로퍼티s
    static let shared = WodViewModel() // 싱글톤 패턴
    
    // MARK: - Simple 프로퍼티s
    @Published var simpleRounds: [(Int, Int, Int)] = [] // 심플 루틴 배열
    @Published var simpleTotalTime:Int = 0 // 심플 루틴 배열의 총 시간
    @Published var simpleRoundIdx: Int?
    @Published var simpleCompletion: Date?
    @Published var simpleDisplay: Int = 0
    
    @Published var simpleState: TimerState = .cancelled {
        didSet {
            switch simpleState {
            case .cancelled, .completed: // 취소 또는 완료
                timerCancellable?.cancel()
                simpleDisplay = 0
                updateCompletionDate()
                
            case .active: // 실행
                startTimer()
                //moveToNextRoundPhase()
                
            case .paused: // 중지
                timerCancellable?.cancel()
                
            case .resumed: // 재개
                startTimer()
                updateCompletionDate()
            }
        }
    }
    // MARK: - 연산 프로퍼티s
    @Published var simpleRoundPhase: SimpleRoundPhase?
    
    // 타이머 메모리 날리기 용
    var timerCancellable: AnyCancellable?
    
    // MARK: - Common Methods
    // ...
    // MARK: - startTimer
     func startTimer() {
         print("타이머 실행")
//         guard timerCancellable == nil else {
//             // 이미 타이머가 동작 중이면 무시
//             return
//         }
         
         timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
             .autoconnect()
             .sink { _ in
                 print(self.simpleDisplay) // 확인
                 self.simpleDisplay -= 1
                 if self.simpleDisplay < 0 {
                     self.timerCancellable?.cancel()
                     
                     
                        self.simpleState = .completed
                         
//                         // 다음 라운드 페이즈로 이동
                        self.moveToNextRoundPhase()
                    
                 }
             }
     }
    
    // MARK: - updateCompletionDate
    func updateCompletionDate() {
        simpleCompletion = Date().addingTimeInterval(Double(simpleDisplay))
        print("완료 \(simpleCompletion)")
        return
    }
}
