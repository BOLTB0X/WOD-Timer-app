//
//  InputManager+Rest.swift
//  Timer
//
//  Created by lkh on 11/20/23.
//

import Foundation

// MARK: - InputManager: InputManager+Rest 입력 관련
extension InputManager {
    private var restTotalSeconds: Int {
        selectedRestAmount.minutes * 60 + selectedRestAmount.seconds
    }
    
    // MARK: - updateField Rest 관련
    func updateRestValuesForField(_ field: Field, newValue: Int) {
        if isCalculatedBtn {
            autoRestCalculator(field, newValue)
        } else {
            nonAutoRestCalculator(field, newValue)
        }
    }
    
    private func nonAutoRestCalculator(_ field: Field, _ newValue: Int) {
        switch field {
        case .hh:
            break
        case .mm:
            if newValue >= 100 {
                selectedRestAmount.minutes = newValue % 100
            } else {
                selectedRestAmount.minutes = newValue >= 60 ? 59 : newValue
            }
        case .ss:
            if newValue >= 100 {
                selectedRestAmount.seconds = newValue % 100
            } else {
                selectedRestAmount.seconds = newValue >= 60 ? 59 : newValue
            }
        }
    }
    
    private func autoRestCalculator(_ field: Field, _ newValue: Int) {
        switch field {
        case .hh:
            break
        case .mm:
            if newValue >= 60 {
                let (_, minutes) = getHoursMinutes(newValue)
                selectedRestAmount.minutes = minutes
            } else {  selectedRestAmount.minutes = newValue }
        case .ss:
            if newValue >= 60 {
                let (_, minutes, seconds) = getHoursMinutesSeconds(newValue)
                selectedRestAmount.minutes += minutes
                selectedRestAmount.seconds = seconds
            } else { selectedRestAmount.seconds = newValue }
        }
    }
}
