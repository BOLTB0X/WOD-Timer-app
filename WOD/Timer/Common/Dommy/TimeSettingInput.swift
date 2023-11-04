//
//  TimeSettingInput.swift
//  Timer
//
//  Created by lkh on 11/4/23.
//

import Foundation

class TimeSettingInput: ObservableObject {
    // MARK: - Picker binding 프로퍼티
    @Published var selectedHoursPicker = 10
    @Published var selectedMinutesPicker = 10
    @Published var selectedSecondsPicker = 10
    
    let hoursRange = Array(0...23)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)
    
    // MARK: - TextField binding 프로퍼티
    @Published var selectedHoursText = 10 {
        didSet {
            selectedHoursText = min(selectedHoursText, 23)
            // TODO
        }
    }
    
    @Published var selectedMinutesText = 10 {
        didSet {
            selectedMinutesText = min(selectedMinutesText, 59)
            // TODO
        }
    }
    
    @Published var selectedSecondsText = 10 {
        didSet {
            selectedSecondsText = min(selectedSecondsText, 59)
            // TODO
        }
    }
    
}
