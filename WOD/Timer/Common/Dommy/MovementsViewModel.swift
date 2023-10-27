//
//  MovementsViewModel.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import Foundation

class MovementsViewModel: ObservableObject {
    @Published var wodArr: [Movements] = []
    @Published var curMovement = Movements()
    @Published var currentIdx: Int = 0
    @Published var currentTime = 0
    
    @Published var selectedHoursAmount = 10
    @Published var selectedMinutesAmount = 10
    @Published var selectedSecondsAmount = 10

    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    init () { }
    
    func addPressed(_ inputMove: InputMovements) {
        wodArr.append(Movements(name: inputMove.name, detail: inputMove.detail, limitTime: inputMove.aim, endTime: "", startTime: "", isRunning: false))
        //wodArr.append(Movements.getDummy())
    }
    
    func deletePressed(_ target: Movements) {
        if let idx = wodArr.firstIndex(where: { $0.id == target.id }) {
            wodArr.remove(at: idx)
        }
    }
    
    func FirstStartPressed() {
        guard let cur = wodArr.first else { return }
        
        curMovement = cur
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        curMovement.startTime = dateFormatter.string(from: Date())
    }
    
    func StartPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        curMovement.endTime = dateFormatter.string(from: Date())
        
        if currentIdx + 1 >= wodArr.count {
            // 운동 완료 뷰로
        } else {
            currentIdx += 1
            curMovement = wodArr[currentIdx]
            curMovement.startTime = dateFormatter.string(from: Date())
        }
        currentTime = 0
    }
}
