//
//  DetailViewModel+Cycle.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - DetailViewModel + Cycle
// 사이클 셋팅 관련
extension DetailViewModel {    
    // MARK: Methods
    // ...
    // MARK: - createCycleItem
    // 운동 이나 휴식 추가
    func createCycleItem() {
        if !betweenRest {
            timerCycleList.append(DetailItem(type: .movement, title: "Movement"))
        } else {
            timerCycleList.append(DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6))
            timerCycleList.append(DetailItem(type: .movement, title: "Movement"))
        }
        return
    }
    
    // MARK: - moveCycleItem
    // 이동
    func moveCycleItem(from source: IndexSet, to destination: Int) {
        timerCycleList.move(fromOffsets: source, toOffset: destination)
        return
    }
    
    // MARK: - insertRestBetweenMovements
    // 휴식 중간에 넣어주기
    func insertRestBetweenMovements() {
        var newList: [DetailItem] = []
        
        for (index, item) in timerCycleList.enumerated() {
            newList.append(item)
            
            if index < timerCycleList.count - 1 {
                newList.append(DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6))
            }
        }
        
        timerCycleList = newList
        return
    }
    
    // MARK: - removeRestBetweenMovements
    // 휴식 제거
    func removeRestBetweenMovements() {
        timerCycleList = timerCycleList.filter { $0.type != .rest }
    }
    
    // MARK: - removeSelectedItems
    // 선택된 item 삭제
    func removeSelectedItems() {
        guard !multiSelection.isEmpty, !timerCycleList.isEmpty, timerCycleList.count > 1 else { return }
        
        timerCycleList.removeAll { multiSelection.contains($0.id) }
        multiSelection.removeAll()
        return
    }
    
    // MARK: - sortTimerCycleList
    // 재정렬
    func sortTimerCycleList() {
        guard timerCycleList.count > 1 else { return }
        
        let movements = timerCycleList.filter { $0.type == .movement }
        let rests = timerCycleList.filter { $0.type == .rest }
        
        var reorderedList: [DetailItem] = []
        
        for i in 0..<(max(movements.count, rests.count)) {
            if i < movements.count {
                reorderedList.append(movements[i])
            }
            
            if i < movements.count - 1 && i < rests.count {
                reorderedList.append(rests[i])
            }
        }
        
        // 업데이트
        timerCycleList = reorderedList
        return
    }
    
    // MARK: - createRemoveButtonAction
    func createRemoveButtonAction(tableType: Binding<Int>, alret: Binding<Bool>) {
        if tableType.wrappedValue == 0 {
            let timerCycleListMove = timerCycleList.filter { $0.type == .movement }.count
            if timerCycleListMove < 15 {
                createCycleItem()
                alretMoniter = .general
            } else {
                alretMoniter = .limitMax
                alret.wrappedValue.toggle()
            }
        } else { // edit 모드
            let timerCycleListMove = timerCycleList.filter { $0.type == .movement }.count
            if multiSelection.isEmpty {
                alretMoniter = .empty
                alret.wrappedValue.toggle()
            } else if timerCycleListMove > 1 && timerCycleListMove > multiSelection.count {
                removeSelectedItems()
                alretMoniter = .general
            } else {
                alretMoniter = .limitOne
                alret.wrappedValue.toggle()
            }
        }
    }
    
    
}

