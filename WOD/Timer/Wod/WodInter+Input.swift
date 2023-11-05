//
//  WodInterViewModel+Input.swift
//  Timer
//
//  Created by lkh on 11/5/23.
//

import Foundation

// MARK: - WodInterViewModel input Field 관련
extension WodInterViewModel {    
    private var totalMinutes: Int {
        selectedHoursAmount * 60 + selectedMinutesAmount
    }
    
    private var totalSeconds: Int {
        totalMinutes * 60 + selectedSecondsAmount
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
    
    // MARK: - updateField 관련
    func updateValuesForField(_ field: Field, newValue: Int) {
        if isCalculatedBtn {
            autoCalculator(field, newValue)
        } else {
            nonAutoCalculator(field, newValue)
        }
    }
    
    private func nonAutoCalculator(_ field: Field, _ newValue: Int) {
        switch field {
        case .hh:
            if newValue >= 100 {
                selectedHoursAmount = newValue % 100
            } else {
                selectedHoursAmount = newValue
            }
        case .mm:
            if newValue >= 100 {
                selectedMinutesAmount = newValue % 100
            } else {
                selectedMinutesAmount = newValue >= 60 ? 59 : newValue
            }
        case .ss:
            if newValue >= 100 {
                selectedSecondsAmount = newValue % 100
            } else {
                selectedSecondsAmount = newValue >= 60 ? 59 : newValue
            }
        }
    }
    
    private func autoCalculator(_ field: Field, _ newValue: Int) {
        switch field {
        case .hh:
            if newValue <= 99 {
                selectedHoursAmount = newValue
            } else {
                selectedHoursAmount = newValue % 100
            }
        case .mm:
            if newValue >= 60 {
                let (hours, minutes) = getHoursMinutes(newValue)
                selectedHoursAmount += hours
                selectedMinutesAmount = minutes
            } else { selectedMinutesAmount = newValue }
        case .ss:
            if newValue >= 60 {
                let (hours, minutes, seconds) = getHoursMinutesSeconds(newValue)
                selectedHoursAmount += hours
                selectedMinutesAmount += minutes
                selectedSecondsAmount = seconds
            } else { selectedSecondsAmount = newValue }
        }
    }
}
