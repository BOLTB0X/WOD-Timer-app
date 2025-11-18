//
//  SimpleViewModel+Common.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI
import Foundation
import ActivityKit

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
            case "Movement":
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
    
    // MARK: - displaySubText
    func displaySubText(state: String) -> String {
        if state == "Preparation" {
            return "Countdown before start"
        } else if state == "Round" {
            return "1Round = Exercise + Rest"
        } else if state == "Movement" {
            return "Exercise Time"
        }
        return "Breaktime after Round"
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
//            AVManager.shared.playSound(named: self.currentTimerRoundString, fileExtension: "caf")
//            AVManager.shared.playSound(named: "round", fileExtension: "caf")
        }
        return
    }
    
    // MARK: - speakingRemainingRound
    func speakingRemainingRound() {
        DispatchQueue.global().async {
//            AVManager.shared.playSound(named: self.currentTimerRemainingString, fileExtension: "caf")
//            AVManager.shared.playSound(named: "round", fileExtension: "caf")
        }
        return
    }
    
    // MARK: - requestOnLiveActivity
    func requestOnLiveActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
        
        let attribute = TimerWidgetAttributes(name: "Simple")
        let state = TimerWidgetAttributes.ContentState(currentState: "Preparation", currentRound: 1, currentDisplayTime: simpleDisplay)
        
        do {
            self.activity = try Activity.request(attributes: attribute, contentState: state)
        } catch (let error) {
            print("Error requesting Live Activity \(error.localizedDescription).")
        }
        
        return
    }
    
    // MARK: - requestOffLiveActivity
    func requestOffLiveActivity() {
        Task {
            await activity?.end(using: nil, dismissalPolicy: .immediate)
        }
    }
    
    // MARK: - updateContentState
    func updateContentState(_ currentState: SimpleRoundPhase, _ currentRound: Int , _ time: Int) {
        if time < 0 { return }
        
        Task {
            let newState = TimerWidgetAttributes.ContentState(currentState: currentState.phaseText, currentRound: currentRound+1, currentDisplayTime: time)
            
            await self.activity?.update(using: newState, alertConfiguration: nil)
        }
    }
}
