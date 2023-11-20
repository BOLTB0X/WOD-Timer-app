//
//  InputManager+Movement.swift
//  Timer
//
//  Created by lkh on 11/20/23.
//

import Foundation

extension InputManager {
    private var moveTotalMinutes: Int {
        selectedMovementAmount.hours * 60 + selectedMovementAmount.minutes
    }
    
    private var moveTotalSeconds: Int {
        moveTotalMinutes * 60 + selectedMovementAmount.seconds
    }
    
    // MARK: - getHoursMinutes
    func getHoursMinutes(_ minutes: Int) -> (Int, Int) {
        let hours = minutes / 60
        let remainMinutes = minutes % 60
        return (hours, remainMinutes)
    }
    
    // MARK: - getHoursMinutesSeconds
    func getHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        let hours = seconds / 3600
        let remainSeconds = seconds % 3600
        let minutes = remainSeconds / 60
        let seconds = remainSeconds % 60
        return (hours, minutes, seconds)
    }
    
    // MARK: - updateField Movements 관련
    func updateMovementValuesForField(_ field: Field, newValue: Int) {
        if isCalculatedBtn {
            autoMovementCalculator(field, newValue)
        } else {
            nonAutoMovementCalculator(field, newValue)
        }
    }
    
    private func nonAutoMovementCalculator(_ field: Field, _ newValue: Int) {
        switch field {
        case .hh:
            if newValue >= 100 {
                selectedMovementAmount.hours = newValue % 100
            } else {
                selectedMovementAmount.hours = newValue
            }
        case .mm:
            if newValue >= 100 {
                selectedMovementAmount.minutes = newValue % 100
            } else {
                selectedMovementAmount.minutes = newValue >= 60 ? 59 : newValue
            }
        case .ss:
            if newValue >= 100 {
                selectedMovementAmount.seconds = newValue % 100
            } else {
                selectedMovementAmount.seconds = newValue >= 60 ? 59 : newValue
            }
        }
    }
    
    private func autoMovementCalculator(_ field: Field, _ newValue: Int) {
        switch field {
        case .hh:
            if newValue <= 99 {
                selectedMovementAmount.hours = newValue
            } else {
                selectedMovementAmount.hours = newValue % 100
            }
        case .mm:
            if newValue >= 60 {
                let (hours, minutes) = getHoursMinutes(newValue)
                selectedMovementAmount.hours += hours
                selectedMovementAmount.minutes = minutes
            } else {  selectedMovementAmount.minutes = newValue }
        case .ss:
            if newValue >= 60 {
                let (hours, minutes, seconds) = getHoursMinutesSeconds(newValue)
                selectedMovementAmount.hours += hours
                selectedMovementAmount.minutes += minutes
                selectedMovementAmount.seconds = seconds
            } else { selectedMovementAmount.seconds = newValue }
        }
    }
}
