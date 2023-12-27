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
    @Published var selectedTimerCycleItem: DetailItem = DetailItem(type: .movement)
    @Published var selectedTimerCycleIndex: Int = 0
    @Published var detailTmRounds: [DetailRound] = [] // 디테일 타이머루틴 배열
    @Published var detailTmRoundIdx: Int? // 진행
    @Published var detailUnitProgress: Float = 0.0
    
    // MARK: - 공통
    @Published var betweenRest: Bool = false {
        didSet {
            if betweenRest {
                insertRestBetweenMovements()
            } else {
                timerCycleList = timerCycleList.filter { $0.type != .rest }
            }
        }
    }
    
    let detailButtonType: [DetailButton] = [.preparation, .round, .cycle, .cycleRest]
    
    
}
