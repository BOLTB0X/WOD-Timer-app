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
    
    // MARK: - Timer
    @Published var timerCycleList: [DetailItem] = [DetailItem(title: "Movement1"), DetailItem(title: "Movement2")]
    @Published var timerRestList: [MovementTime] = []
    @Published var selectedTimerCycleItem: DetailItem = DetailItem()
    @Published var selectedTimerCycleIndex: Int = 0
    @Published var detailTmRounds: [DetailRound] = [] // 디테일 타이머루틴 배열
    @Published var detailTmRoundIdx: Int? // 진행
    @Published var detailUnitProgress: Float = 0.0
    
    // MARK: - 공통
    @Published var betweenRest: Bool = false {
        didSet {
            if betweenRest {
                let restCount = max(timerCycleList.count - 1, 0)
                timerRestList = Array(repeating: MovementTime(seconds: 0), count: restCount)
            } else {
                timerRestList = []
            }
        }
    }
    
    
    
    let detailButtonType: [DetailButton] = [.preparation, .round, .cycle, .cycleRest]
    
    
}
