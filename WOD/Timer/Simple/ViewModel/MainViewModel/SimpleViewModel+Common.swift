//
//  SimpleViewModel+Common.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI
import Foundation

// MARK: - SimpleViewModel + Common
// 공통적으로 사용할 메세지(Color, AV 등)
extension SimpleViewModel {
    // MARK: - Methods
    // ..
    // MARK: - displaySetValue
    func displaySimpleSetValue(state: String, mode: Int) -> String {
        if mode == 0 { // Timer
            switch state {
            case "Round":
                return String(selectedRoundAmount)
            case "Preparation":
                return String(format: "00:%02d", selectedPreparationAmount)
            case "Movements":
                if selectedMovementAmount.hours > 0 {
                    return String(format: "%02d:%02d:%02d",
                                  selectedMovementAmount.hours,
                                  selectedMovementAmount.minutes,
                                  selectedMovementAmount.seconds)
                } else {
                    return String(format: "%02d:%02d", selectedMovementAmount.minutes, selectedMovementAmount.seconds)
                }
            case "Rest":
                return String(format: "%02d:%02d", selectedRestAmount.minutes,selectedRestAmount.seconds)
            default:
                return ""
            }
        } else { // Stopwatch
            if state == "Round" {
                return String(selectedRoundStop)
            } else if state == "Preparation" {
                return String(format: "00:%02d", selectedPreparationStop)
            }
            return "Yourself Stop"
        }
    }
    
    // MARK: - updateCompletionDate
    func updateSimpleCompletionDate() {
        simpleCompletion = Date().addingTimeInterval(Double(simpleDisplay))
        print("완료", simpleCompletion ?? "")
        return
    }
    
    // MARK: - updateBackgroundColor
    func updateBackgroundColor() {
        guard let phase = simpleRoundPhase else { return }
        
        switch phase {
        case .preparation:
            phaseBackgroundColor = Color.randomPreparationColor()
        case .movement:
            phaseBackgroundColor = Color.randomMovementColor()
        case .rest:
            phaseBackgroundColor = Color.randomRestColor()
        case .completed:
            phaseBackgroundColor = Color(.systemGray)
        }
    }
    
    // MARK: - speakingProcessingRound
    func speakingProcessingRound() {
        DispatchQueue.global().async {
            AVManager.shared.playSound(named: self.currentTimerRoundString, fileExtension: "caf")
            AVManager.shared.playSound(named: "round", fileExtension: "caf")
        }
        return
    }
    
    // MARK: - speakingRemainingRound
    func speakingRemainingRound() {
        DispatchQueue.global().async {
            AVManager.shared.playSound(named: self.currentTimerRemainingString, fileExtension: "caf")
            AVManager.shared.playSound(named: "round", fileExtension: "caf")
        }
        return
    }
}
