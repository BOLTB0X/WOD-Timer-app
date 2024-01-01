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
    @Published var timerCycleList: [DetailItem] = [DetailItem(type: .movement, title: "Movement1"), DetailItem(type: .movement, title: "Movement2")]
    @Published var selectedTimerCycleIndex: Int = 0
    @Published var detailTmRounds: [DetailRound] = [] // 디테일 타이머 배열
    @Published var detailTmRoundIdx: Int? // 진행
    @Published var detailUnitProgress: Float = 0.0
    
    // MARK: - Stopwatch
    @Published var StopCycleList: [DetailItem] = [DetailItem(type: .movement, title: "Movement1"), DetailItem(type: .movement, title: "Movement2")]
    @Published var selectedStopCycleIndex: Int = 0
    @Published var detailSwRounds: [DetailRound] = [] // 디테일 스톱워치 배열
    @Published var detailSwRoundIdx: Int? // 진행
    
    // MARK: - Common
    @Published var defaultMove: DetailItem = DetailItem(type: .movement, title: "Movement")
    @Published var defaultRest: DetailItem = DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6)
    @Published var alretMoniter: AlertType = .general
    @Published var multiSelection: Set<UUID> = []
    @Published var createType: DetailItemType = .movement
    @Published var betweenRest: Bool = false {
        didSet {
            if betweenRest {
                insertRestBetweenMovements()
            } else {
                removeRestBetweenMovements()
                //timerCycleList = timerCycleList.filter { $0.type != .rest }
            }
        }
    }
    
    let detailButtonType: [DetailButton] = [.preparation, .round, .cycle, .cycleRest]
}
