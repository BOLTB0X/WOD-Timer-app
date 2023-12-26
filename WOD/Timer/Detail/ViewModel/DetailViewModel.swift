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
    @Published var timerCycleList: [DetailItem] = [DetailItem(title: "Movement"), DetailItem(title: "Rest", time: 10)]
    @Published var selectedCycleItem: DetailItem = DetailItem()
    // MARK: - 공통
    let detailButtonType: [DetailButton] = [.preparation, .round, .cycle, .cycleRest]
    let colorOptions: [String] = ["lightBlue2", "lightBlue3", "lightBlue4", "lightBlue1", "lightGreen1", "lightGreen2", "lightGreen3", "lightGreen4", "lightYellow1", "lightYellow3", "lightYellow2", "lightYellow4", "lightRed1", "lightRed2", "lightRed3", "lightRed4", "lightWhite"]
    
    // MARK: createTimerCycleElements
    
    // MARK: updateTimerCycleElements
    
    // MARK: removeTimerCycleElements
    
    
    // MARK: ..
    func findColorIndex() -> Int {
        for i in 0..<colorOptions.count {
            if colorOptions[i] == selectedCycleItem.color {
                return i
            }
        }
        return 0
    }
}
