//
//  SimpleTimerManager.swift
//  Timer
//
//  Created by lkh on 11/17/23.
//

import Foundation
import Combine

class SimpleTimerManager: ObservableObject {
    @Published var preparationTime: MovementTime
    @Published var movementTime: MovementTime
    @Published var restTime: MovementTime
    @Published var totalTime: MovementTime
    
    private var cancellables: Set<AnyCancellable> = []

    var timer: Timer?
    
    init(preparationTime: MovementTime, movementTime: MovementTime, restTime: MovementTime) {
        self.preparationTime = preparationTime
        self.movementTime = movementTime
        self.restTime = restTime
        self.totalTime = preparationTime + movementTime + restTime
    }
    
    func startTimer() {
        cancellables.removeAll()  // 기존 cancellables 제거
        
        // TODO: 로직 완성하기
    }
}
