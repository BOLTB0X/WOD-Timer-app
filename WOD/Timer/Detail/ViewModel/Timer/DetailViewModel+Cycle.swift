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
    } // createCycleItem
    
    // MARK: - createMovementItem
    // 운동 추가
    func createMovementItem() {
        if !betweenRest {
            timerCycleList.append(DetailItem(type: .movement, title: "Movement"))
        } else {
            timerCycleList.append(DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6))
            timerCycleList.append(DetailItem(type: .movement, title: "Movement"))
        }
        return
    } // createMovementItem
    
    // MARK: - createRestItem
    // 휴식 추가
    func createRestItem() {
        if !betweenRest {
            timerCycleList.append(DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6))
        }
        return
    } // createRestItem
    
    
    // MARK: - moveCycleItem
    // 이동
    func moveCycleItem(from source: IndexSet, to destination: Int) {
        timerCycleList.move(fromOffsets: source, toOffset: destination)
        return
    } // moveCycleItem
    
    // MARK: - insertRestBetweenMovements
    // 휴식 중간에 넣어주기
    func insertRestBetweenMovements() {
        var newList: [DetailItem] = []
        
        for (index, item) in timerCycleList.enumerated() {
            newList.append(item)
            
            if timerCycleList[index].type == .rest {
                continue
            }
            
            if index < timerCycleList.count - 1 && timerCycleList[index+1].type == .rest {
                continue
            }
            
            if index < timerCycleList.count - 1 {
                newList.append(DetailItem(type: .rest, title: "Rest", time: MovementTime(seconds: 10), color: 6))
            }
        }
        
        timerCycleList = newList
        return
    } // insertRestBetweenMovements
    
    // MARK: - removeRestBetweenMovements
    // 휴식 제거
    func removeRestBetweenMovements() {
        timerCycleList = timerCycleList.filter { $0.type != .rest }
    } // removeRestBetweenMovements
    
    // MARK: - removeSelectedItems
    // 선택된 item 삭제
    func removeSelectedItems() {
        guard !multiSelection.isEmpty, !timerCycleList.isEmpty, timerCycleList.count > 1 else { return }
        
        timerCycleList.removeAll { multiSelection.contains($0.id) }
        multiSelection.removeAll()
        return
    } // removeSelectedItems
    
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
    } // sortTimerCycleList
    
    // MARK: - createRemoveButtonAction
    func createRemoveButtonAction(tableType: Binding<Int>, alret: Binding<Bool>) {
        if tableType.wrappedValue == 0 {
            if createType == .movement {
                isCreatetypeMove(tableType: tableType, alret: alret)
            } else {
                isCreatetypeRest(tableType: tableType, alret: alret)
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
    } // createRemoveButtonAction
    
    // MARK: - isCreatetypeMove
    private func isCreatetypeMove(tableType: Binding<Int>, alret: Binding<Bool>) {
        let timerCycleListMove = timerCycleList.filter { $0.type == .movement }.count
        
        if timerCycleListMove < 15 {
            createMovementItem()
            alretMoniter = .general
        }
        else {
            alretMoniter = .limitMoveMax
            alret.wrappedValue.toggle()
        }
    } // isCreatetypeMove
    
    // MARK: - isCreatetypeRest
    private func isCreatetypeRest(tableType: Binding<Int>, alret: Binding<Bool>) {
        let timerCycleListMove = timerCycleList.filter { $0.type == .movement }.count
        let timerCycleListRest = timerCycleList.filter { $0.type == .rest }.count
        
        if timerCycleListMove - 1 > timerCycleListRest {
            createRestItem()
            alretMoniter = .general
            sortTimerCycleList()
        } else {
            alretMoniter = .limitRestMax
            alret.wrappedValue.toggle()
        }
    } // isCreatetypeRest
    
}

