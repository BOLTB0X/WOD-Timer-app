//
//  TimerWidgetAttributes.swift
//  Timer
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - TimerWidgetAttributes
struct TimerWidgetAttributes: ActivityAttributes {
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var currentState: String
        var currentDisplayTime: Int
    }

    var name: String
}

