//
//  DetailViewModel+Cycle.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import Foundation

// MARK: - DetailViewModel + Cycle
// 사이클 셋팅 관련
extension DetailViewModel {
    // MARK: Methods
    // ...
    // MARK: - createCycleItem
    func createCycleItem() {
        timerCycleList.append(DetailItem(title: "Movement\(timerCycleList.count + 1)"))
        return
    }
    
    // MARK: - removeCycleItem
    func removeCycleItem(at offsets: IndexSet) {
        timerCycleList.remove(atOffsets: offsets)
        return
    }
    
    // MARK: - moveCycleItem
    func moveCycleItem(from source: IndexSet, to destination: Int) {
        timerCycleList.move(fromOffsets: source, toOffset: destination)
        return
    }
}

