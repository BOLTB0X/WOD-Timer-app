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
        if !betweenRest {
            timerCycleList.append(DetailItem(type: .movement, title: "Movement\(timerCycleList.count + 1)"))
        } else {
            timerCycleList.append(DetailItem(type: .rest, title: "Rest"))
            timerCycleList.append(DetailItem(type: .movement, title: "Movement\(timerCycleList.count + 1)"))
        }
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
    
    // MARK: - insertRestBetweenMovements
    func insertRestBetweenMovements() {
        var newList: [DetailItem] = []
        
        for (index, item) in timerCycleList.enumerated() {
            newList.append(item)
            
            if index < timerCycleList.count - 1 {
                newList.append(DetailItem(type: .rest, title: "Rest"))
            }
        }
        
        timerCycleList = newList
        return
    }
    
    // MARK: - removeRestBetweenMovements
    func removeRestBetweenMovements() {
        // 휴식을 나타내는 DetailItem을 제거
        timerCycleList = timerCycleList.filter { $0.type != .rest }
    }
}

