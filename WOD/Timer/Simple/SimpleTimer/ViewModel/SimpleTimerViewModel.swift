//
//  SimpleTimerViewmodel.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/21/25.
//

import SwiftUI
import Foundation
import Combine

// MARK: - SimpleTimerViewModel
final class SimpleTimerViewModel: ObservableObject, SimpleEngine {
    
    // SimpleEngine
    // ...
    @Published var roundArray: [SimpleRound] = []
    @Published var roundTotalTime: Int = 0
    @Published var roundIndex: Int?
    @Published var displayTime: Int = 0
    @Published var engineState: TimerState = .cancelled {
        didSet {
            switch engineState {
            case .cancelled:
                canclled {
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
    var cancellable: AnyCancellable?
    
    // SimpleTimerViewModel
    // ...
    @Published var simpleRoundPhase: SimpleRoundPhase?
    @Published var phaseBackgroundColor: Color = .clear
    @Published var controlBtn: Bool = false
    @Published var unitProgress: Float = 0.0
    
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
                    self.roundTotalTime -= 1
                }
                
                self.displayTime -= 1
                
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
    
    // MARK: - createRounds
    func createRounds(selectedRoundAmount: Int,
                      selectedMovementAmount: MovementTime,
                      selectedRestAmount: MovementTime) {
        roundArray = [] // 초기화
        
        for i in 0..<selectedRoundAmount {
            if i == selectedRoundAmount - 1 {
                roundArray.append(SimpleRound(movement: selectedMovementAmount.totalSeconds, rest: 0, date: StartComplted()))
            } else {
                roundArray.append(SimpleRound(movement: selectedMovementAmount.totalSeconds, rest: selectedRestAmount.totalSeconds, date: StartComplted()))
            }
        } // for
        
        roundTotalTime = roundArray.reduce(0) { $0 + ($1.movement + $1.rest) }
        return
    } // createRounds
    
} // SimpleTimerViewModel

// MARK: - helper
extension SimpleTimerViewModel {
    
    // MARK: - calculateProgress
    private func calculateProgress(currentPhase: SimpleRoundPhase,
                                   currentRound: SimpleRound,
                                   preparationAmount: Int) {
        switch currentPhase {
        case .preparation:
            let elapsedTime = preparationAmount - displayTime
            unitProgress = Float(elapsedTime) / Float(preparationAmount)
        case .movement:
            let totalSeconds = currentRound.movement
            let elapsedTime = totalSeconds - displayTime
            unitProgress = Float(elapsedTime) / Float(totalSeconds)
        case .rest:
            let totalSeconds = currentRound.rest
            let elapsedTime = totalSeconds - displayTime
            unitProgress = Float(elapsedTime) / Float(totalSeconds)
        default:
            unitProgress = 0.0
        }
        return
    } // calculateProgress
    
}
