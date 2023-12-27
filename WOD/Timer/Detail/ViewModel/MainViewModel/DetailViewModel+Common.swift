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
            case "Cycle":
                return "\(timerCycleList.count)"
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
            } else if state == "Cycle" {
                return "\(timerCycleList.count)"
            }
            return "Yourself Stop"
        }
    }
}
