//
//  DetailViewModel+Common.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI
import Foundation

// MARK: - DetailViewModel + Common
// 공통적으로 사용할 메세지(Color, AV 등)
extension DetailViewModel {
    // MARK: - 연산 프로퍼티s
    // ...
    // MARK: - alretMessage
    var alretMessage: String {
        switch alretMoniter {
        case .limitOne:
            return "At least 1 required"
        case .quit:
            return "Are you sure you want to quit?"
        case .save:
            return "Do you want to save it as My set?"
        case .empty:
            return "Nothing currently selected"
        default:
            return "~~"
        }
    }
    
    
    // MARK: - Methods
    // ..
    // MARK: - displaySetValue
    func displayDetailSetValue(state: String, mode: Int) -> String {
        if mode == 0 {
            switch state {
            case "Round":
                return String(selectedRoundAmount)
            case "Preparation":
                return String(format: "00:%02d", selectedPreparationAmount)
            case "Movement loop":
                return ">"
            case "Rest":
                return String(format: "%02d:%02d", selectedRestAmount.minutes,selectedRestAmount.seconds)
            default:
                return ""
            }
        } else {
            if state == "Round" {
                return String(selectedRoundAmount)
            } else if state == "Preparation" {
                return String(format: "00:%02d", selectedPreparationStop)
            } else if state == "Self section" {
                return "Set Yourself, Yourself Stop"
            }
            return "Yourself Stop"
        }
    }
    
    // MARK: - displaySubText
    func displaySubText(state: String) -> String {
        if state == "Preparation" {
            return "Countdown before start"
        } else if state == "Round" {
            return "1Round = Loop + Rest"
        } else if state == "Rest" {
            return "Breaktime after loop"
        } else if state == "Movement loop" {
            return "Your exercises + opional Rest"
        }
        return ""
    }
    
    // MARK: - updateDetailCompletionDate
    func updateDetailCompletionDate() {
        detailCompletion = Date().addingTimeInterval(Double(detailDisplay))
        print("완료", detailCompletion ?? "")
        return
    }
    
    // MARK: - updateBackgroundColor
    func updateBackgroundColor() {
        guard let phase = detailRoundPhase, let idx = detailTmRoundIdx else { return }
        
        switch phase {
        case .preparation:
            phaseBackgroundColor = Color(timerPreparationColor.IndexToColor)
        case .loopMovement, .loopRest:
            if let color = detailTmRounds[idx].color {
                phaseBackgroundColor = Color(color.IndexToColor)
            }
        case .rest:
            phaseBackgroundColor = Color(timerRestColor.IndexToColor)
        case .completed:
            phaseBackgroundColor = Color(.systemGray)
        }
    }
}
