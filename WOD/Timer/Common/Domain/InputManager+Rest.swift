//
//  InputManager+Rest.swift
//  Timer
//
//  Created by lkh on 11/20/23.
//

import Foundation

// MARK: - InputManager: InputManager+Rest 입력 관련
extension InputManager {
    // MARK: - 연산 프로퍼티s
    // ..
    // MARK: - restTotalSeconds
    private var restTotalSeconds: Int {
        selectedRestAmount.minutes * 60 + selectedRestAmount.seconds
    }
    
    /*==================================================================================*/
    // MARK: - Methods
    // ..
    // MARK: - updateField Rest 관련
    
    // MARK: - updateRestValuesForField
    func updateRestValuesForField(_ field: Field, newValue: Int) {
        if isCalculatedBtn {
            autoRestCalculator(field, newValue)
        } else {
            nonAutoRestCalculator(field, newValue)
        }
    }
    
    // MARK: - nonAutoRestCalculator
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
    
    // MARK: - autoRestCalculator
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
    } // autoRestCalculator
}
