//
//  TimerWidgetLiveActivity.swift
//  TimerWidget
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SimpleWidgetAttributes.self) { context in
            
            // MARK: - Notification
            LockScreenLiveActivityView(context: context)
                .activitySystemActionForegroundColor(Color.black)
            

        } dynamicIsland: { context in
            DynamicIsland {
                // MARK: - Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "hourglass.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.currentDisplayTime.asTimestamp)
                        .frame(width: 50)
                        .monospacedDigit()
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    
                    // more content
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
    }
}

struct TimerWidgetLiveActivity_Previews: PreviewProvider {
    static let attributes = SimpleWidgetAttributes(name: "Timer")
    static let contentState = SimpleWidgetAttributes.ContentState(currentState: "Rest", currentRound: 1, currentDisplayTime: 50)

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
