//
//  TimerWidgetAttributes.swift
//  Timer
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - SimpleWidgetAttributes
struct TimerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var currentState: String
        var currentRound: Int
        var currentDisplayTime: Int
    }
    
    var name: String
}
