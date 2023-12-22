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
    @Published var dynamicMovement: [SimpleRound] = [] // 심플 타이머루틴 배열

    
    // MARK: - 공통
    let detailButtonType: [DetailButton] = [.preparation, .round, .cycle, .cycleRest]
}
