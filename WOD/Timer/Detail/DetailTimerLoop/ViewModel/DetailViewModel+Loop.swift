//
//  DetailViewModel+Cycle.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - DetailViewModel + Loop
// 사이클 셋팅 관련
extension DetailViewModel {
    // MARK: Methods
    // ...    
    // MARK: - createMovementItem
    // 운동 추가
    func createMovementItem() {
        if !betweenRest {
            timerLoopList.append(defaultMove)
        } else {
            timerLoopList.append(defaultRest)
            timerLoopList.append(defaultMove)
        }
        return
    } // createMovementItem
        
    // MARK: - moveCycleItem
    // 이동
    func moveCycleItem(from source: IndexSet, to destination: Int) {
        timerLoopList.move(fromOffsets: source, toOffset: destination)
     
        return
    } // moveCycleItem
    
    // MARK: - insertRestBetweenMovements
    // 휴식 중간에 넣어주기
    func insertRestBetweenMovements() {
        var newList: [DetailItem] = []
        
        for (index, item) in timerLoopList.enumerated() {
            newList.append(item)
            
            if timerLoopList[index].type == .rest {
                continue
            }
            
            if index < timerLoopList.count - 1 && timerLoopList[index+1].type == .rest {
                continue
            }
            
            if index < timerLoopList.count - 1 {
                newList.append(defaultRest)
            }
        }
        
        timerLoopList = newList
        return
    } // insertRestBetweenMovements
    
    // MARK: - removeRestBetweenMovements
    // 휴식 제거
    func removeRestBetweenMovements() {
        timerLoopList = timerLoopList.filter { $0.type == .movement }
        return
    } // removeRestBetweenMovements
    
    // MARK: - removeSelectedItems
    // 선택된 item 삭제
    func removeSelectedItems() {
        guard !multiSelection.isEmpty, !timerLoopList.isEmpty, timerLoopList.count > 1 else { return }
        
        timerLoopList.removeAll { multiSelection.contains($0.id) }
        multiSelection.removeAll()
        return
    } // removeSelectedItems
    
    // MARK: - sortTimerCycleList
    // 재정렬
    func sortTimerCycleList() {
        guard timerLoopList.count > 1 else { return }
        
        let movements = timerLoopList.filter { $0.type == .movement }
        let rests = timerLoopList.filter { $0.type == .rest }
        
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
        timerLoopList = reorderedList
        return
    } // sortTimerCycleList
    
    // MARK: - createRemoveButtonAction
    func createRemoveButtonAction(tableType: Binding<Int>, alret: Binding<Bool>) {
        if tableType.wrappedValue == 0 {
            createMovementItem()
        } else { // edit 모드
            let timerCycleListMove = timerLoopList.filter { $0.type == .movement }.count

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
        } // if - else
    } // createRemoveButtonAction
   
    
}

