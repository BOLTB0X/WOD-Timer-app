//
//  TimerWidgetAttributes.swift
//  Timer
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerWidgetAttributes: ActivityAttributes {
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var currentDisplayTime: Int
    }

    var name: String
}

