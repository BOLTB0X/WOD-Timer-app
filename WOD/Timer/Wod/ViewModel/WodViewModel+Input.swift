//
//  WodViewModel+Input.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import Foundation

extension WodViewModel {
//    private var totalMinutes: Int {
//        selectedMovementAmount.hours * 60 + selectedMovementAmount.minutes
//    }
//    
//    private var totalSeconds: Int {
//        totalMinutes * 60 + selectedMovementAmount.seconds
//    }
//    
//    // MARK: - getHoursMinutes
//    func getHoursMinutes(_ minutes: Int) -> (Int, Int) {
//        let hours = minutes / 60
//        let remainMinutes = minutes % 60
//        return (hours, remainMinutes)
//    }
//    
//    // MARK: - getHoursMinutesSeconds
//    func getHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
//        let hours = seconds / 3600
//        let remainSeconds = seconds % 3600
//        let minutes = remainSeconds / 60
//        let seconds = remainSeconds % 60
//        return (hours, minutes, seconds)
//    }
//    
//    // MARK: - updateField 관련
//    func updateValuesForField(_ field: Field, newValue: Int) {
//        if isCalculatedBtn {
//            autoCalculator(field, newValue)
//        } else {
//            nonAutoCalculator(field, newValue)
//        }
//    }
//    
//    private func nonAutoCalculator(_ field: Field, _ newValue: Int) {
//        switch field {
//        case .hh:
//            if newValue >= 100 {
//                selectedMovementAmount.hours = newValue % 100
//            } else {
//                selectedMovementAmount.hours = newValue
//            }
//        case .mm:
//            if newValue >= 100 {
//                selectedMovementAmount.minutes = newValue % 100
//            } else {
//                selectedMovementAmount.minutes = newValue >= 60 ? 59 : newValue
//            }
//        case .ss:
//            if newValue >= 100 {
//                selectedMovementAmount.seconds = newValue % 100
//            } else {
//                selectedMovementAmount.seconds = newValue >= 60 ? 59 : newValue
//            }
//        }
//    }
//    
//    private func autoCalculator(_ field: Field, _ newValue: Int) {
//        switch field {
//        case .hh:
//            if newValue <= 99 {
//                selectedMovementAmount.hours = newValue
//            } else {
//                selectedMovementAmount.hours = newValue % 100
//            }
//        case .mm:
//            if newValue >= 60 {
//                let (hours, minutes) = getHoursMinutes(newValue)
//                selectedMovementAmount.hours += hours
//                selectedMovementAmount.minutes = minutes
//            } else {  selectedMovementAmount.minutes = newValue }
//        case .ss:
//            if newValue >= 60 {
//                let (hours, minutes, seconds) = getHoursMinutesSeconds(newValue)
//                selectedMovementAmount.hours += hours
//                selectedMovementAmount.minutes += minutes
//                selectedMovementAmount.seconds = seconds
//            } else { selectedMovementAmount.seconds = newValue }
//        }
//    }
}
