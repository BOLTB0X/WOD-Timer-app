//
//  SimpleStopwatchViewModel.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/21/25.
//

import SwiftUI
import Foundation
import Combine

// MARK: - SimpleStopwatchViewModel
final class SimpleStopwatchViewModel: ObservableObject, SimpleEngine {
    
    // SimpleEngine
    // ...
    @Published var roundArray: [SimpleRound] = []
    @Published var roundTotalTime: Int = 0
    @Published var roundIndex: Int?
    @Published var displayTime: Int = 0
    var cancellable: AnyCancellable?

    
    // SimpleStopwatchViewModel
    // ...
    @Published var simpleRoundPhase: SimpleRoundPhase?
    @Published var phaseBackgroundColor: Color = .clear
    @Published var controlBtn: Bool = false
    
    @Published var engineState: TimerState = .cancelled {
        didSet {
            switch engineState {
            case .cancelled:
                canclled {
                    // [Timer 고유 로직]: 완료일 업데이트, 라이브 액티비티 끄기 등
                    // requestOffLiveActivity()
                }
                controlBtn = false
            case .completed:
                completed {
                    // self.nextSimpleTimerRoundPhase()
                }
                
            case .active:
                start()
            case .paused:
                pause()
            case .resumed:
                resume()
                controlBtn = false
            }
        }
    } // engineState

    // impl
    // ...
    func start() {
        guard let idx = roundIndex,
              idx < roundArray.count,
              let currentPhase = simpleRoundPhase
        else { return }
        
        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.displayTime > 0 && currentPhase != .preparation {
                    self.roundTotalTime += 1
                }
                
                if currentPhase == .preparation {
                    self.displayTime -= 1
                    if self.displayTime < 0 {
                        //self.completedCurrentStop()
                    }
                } else { // 나머진 그냥 증가
                    self.displayTime += 1
                }
                
                //self.updateContentState(currentPhase, idx, self.simpleDisplay)
                
                // 5초 이하일 때 countdown 사운드 재생
//                if self.displayTime <= 5 && self.displayTime > 0 {
//                    AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
//                    
//                } else if self.displayTime == 0 {
//                    AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
//                }
//                
//                DispatchQueue.main.async {
//                    self.updateSimpleUnitProgress()
//                }
                
                if self.displayTime < 0 {
                    //self.completedCurrentTimer() // 완료
                }
                
            } // sink
    } // start
    
    
} // SimpleStopwatchViewModel
