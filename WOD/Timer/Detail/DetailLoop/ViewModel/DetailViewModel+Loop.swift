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
    func createMovementItem(_ mode: Int) {
        var dMove = DetailItem(type: .movement, title: defaultMove.title, time: defaultMove.time, color: defaultMove.color)
        var dRest = DetailItem(type: .rest, title: defaultRest.title, time: defaultRest.time, color: defaultRest.color)
        
        if mode == 0 { // 타이머
            if !betweenRestInTimer {
                timerLoopList.append(dMove)
            } else {
                timerLoopList.append(dRest)
                timerLoopList.append(dMove)
            }
        } else { // 스톱워치
            if !betweenRestInStop {
                dMove.time = MovementTime(seconds: 0)
                stopLoopList.append(dMove)
            } else {
                dMove.time = MovementTime(seconds: 0)
                dRest.time = MovementTime(seconds: 0)
                stopLoopList.append(dRest)
                stopLoopList.append(dMove)
            }
        }

        return
    } // createMovementItem
        
    // MARK: - moveTimerLoopItem
    // 이동
    func moveTimerLoopItem(from source: IndexSet, to destination: Int) {
        timerLoopList.move(fromOffsets: source, toOffset: destination)
     
        return
    } // moveTimerLoopItem
    
    // MARK: - moveStopLoopItem
    // 이동
    func moveStopLoopItem(from source: IndexSet, to destination: Int) {
        stopLoopList.move(fromOffsets: source, toOffset: destination)
     
        return
    } // moveStopLoopItem
    
    // MARK: - insertRestBetweenMovementsInTimer
    // 휴식 중간에 넣어주기
    func insertRestBetweenMovementsInTimer() {
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
    } // insertRestBetweenMovementsInTimer
    
    // MARK: - insertRestBetweenMovementsInStop
    // 휴식 중간에 넣어주기
    func insertRestBetweenMovementsInStop() {
        var newList: [DetailItem] = []
        
        for (index, item) in stopLoopList.enumerated() {
            newList.append(item)
            
            if stopLoopList[index].type == .rest {
                continue
            }
            
            if index < stopLoopList.count - 1 && stopLoopList[index+1].type == .rest {
                continue
            }
            
            if index < stopLoopList.count - 1 {
                var dRest = defaultRest
                dRest.time = MovementTime(seconds: 0)
                newList.append(dRest)
            }
        }
        
        stopLoopList = newList
        return
    } // insertRestBetweenMovementsInStop
    
    // MARK: - removeRestBetweenMovementsInTimer
    // 휴식 제거
    func removeRestBetweenMovementsInTimer() {
        timerLoopList = timerLoopList.filter { $0.type == .movement }
        return
    } // removeRestBetweenMovementsInTimer
    
    // MARK: - removeRestBetweenMovementsInStop
    // 휴식 제거
    func removeRestBetweenMovementsInStop() {
        stopLoopList = stopLoopList.filter { $0.type == .movement }
        return
    } // removeRestBetweenMovementsInStop
    
    // MARK: - removeSelectedTimerItems
    // 선택된 item 삭제
    func removeSelectedTimerItems() {
        guard !multiSelection.isEmpty, !timerLoopList.isEmpty, timerLoopList.count > 1 else { return }
        
        timerLoopList.removeAll { multiSelection.contains($0.id) }
        multiSelection.removeAll()
        return
    } // removeSelectedTimerItems
    
    // MARK: - removeSelectedStopItems
    // 선택된 item 삭제
    func removeSelectedStopItems() {
        guard !multiSelection.isEmpty, !stopLoopList.isEmpty, stopLoopList.count > 1 else { return }
        
        stopLoopList.removeAll { multiSelection.contains($0.id) }
        multiSelection.removeAll()
        return
    } // removeSelectedStopItems
    
    // MARK: - sortTimerLoopList
    // 재정렬
    func sortTimerLoopList() {
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
    } // sortTimerLoopList
    
    // MARK: - sortStopLoopList
    // 재정렬
    func sortStopLoopList() {
        guard stopLoopList.count > 1 else { return }
        
        let movements = stopLoopList.filter { $0.type == .movement }
        let rests = stopLoopList.filter { $0.type == .rest }
        
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
        stopLoopList = reorderedList
        return
    } // sortStopLoopList
    
    // MARK: - createRemoveButtonAction
    func createRemoveButtonAction(tableType: Binding<Int>, alret: Binding<Bool>, mode: Int) {
        if tableType.wrappedValue == 0 {
            createMovementItem(mode)
        } else { // edit 모드
            if mode == 0 {
                updateTimerLoopList(tableType: tableType, alret: alret)
            } else {
                updateStopLoopList(tableType: tableType, alret: alret)
            }
        } // if - else
    } // createRemoveButtonAction
   
    // MARK: - updateTimerLoopList
    private func updateTimerLoopList(tableType: Binding<Int>, alret: Binding<Bool>) {
        let timerCycleListMove = timerLoopList.filter { $0.type == .movement }.count
        
        if multiSelection.isEmpty {
            alretMoniter = .empty
            alret.wrappedValue.toggle()
        } else if timerCycleListMove > 1 && timerCycleListMove > multiSelection.count {
            removeSelectedTimerItems()
            alretMoniter = .general
        } else {
            alretMoniter = .limitOne
            alret.wrappedValue.toggle()
        }
        return
    } // updateTimerLoopList
    
    // MARK: - updateStopLoopList
    private func updateStopLoopList(tableType: Binding<Int>, alret: Binding<Bool>) {
        let stopCycleListMove = stopLoopList.filter { $0.type == .movement }.count
        
        if multiSelection.isEmpty {
            alretMoniter = .empty
            alret.wrappedValue.toggle()
        } else if stopCycleListMove > 1 && stopCycleListMove > multiSelection.count {
            removeSelectedStopItems()
            alretMoniter = .general
        } else {
            alretMoniter = .limitOne
            alret.wrappedValue.toggle()
        }
        return
    } // updateStopLoopList
}

