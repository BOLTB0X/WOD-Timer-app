//
//  TimerWidgetLiveActivity.swift
//  TimerWidget
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - TimerWidgetLiveActivity
struct TimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerWidgetAttributes.self) { context in
            
            // MARK: - Notification
            LockScreenLiveActivityView(context: context)
                .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // MARK: - Expanded UI
                DynamicIslandExpandedRegion(.center) {
                    ExpandedLiveActivityView(context: context)
                }
                
                // MARK: - Island Compact
            } compactLeading: {
                Text(context.state.currentState)
            } compactTrailing: {
                Text(context.state.currentDisplayTime.asTimestamp)
                // MARK: - minimal
            } minimal: {
                Image(systemName: "timer")
                    .foregroundColor(.blue)
            }
        }
    } // body
}

struct TimerWidgetLiveActivity_Previews: PreviewProvider {
    static let attributes = TimerWidgetAttributes(name: "Timer")
    static let contentState = TimerWidgetAttributes.ContentState(currentState: "Rest", currentRound: 1, currentDisplayTime: 50)
    
    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
