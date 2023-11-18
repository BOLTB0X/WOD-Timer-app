//
//  SimpleTimerManager.swift
//  Timer
//
//  Created by lkh on 11/17/23.
//

import Foundation
import Combine

class SimpleTimerManager: ObservableObject {
    static let shared = SimpleTimerManager()
    
    @Published var roundCount: Int
    @Published var preparationTime: MovementTime
    @Published var movementTime: MovementTime
    @Published var restTime: MovementTime
    @Published var totalTime: MovementTime
    
    var timer: Timer?
    
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {
        roundCount = 0
        preparationTime = MovementTime(hours: 0, minutes: 0, seconds: 0)
        movementTime = MovementTime(hours: 0, minutes: 0, seconds: 0)
        restTime = MovementTime(hours: 0, minutes: 0, seconds: 0)
        totalTime = MovementTime(hours: 0, minutes: 0, seconds: 0)
    }
    
    func startTimer() {
        cancellables.removeAll()  // 기존 cancellables 제거
        
        // TODO: 로직 완성하기
    }
}
