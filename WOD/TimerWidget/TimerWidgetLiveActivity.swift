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
        ActivityConfiguration(for: TimerWidgetAttributes.self) { context in
            // MARK: - Notification
            // Lock screen/banner UI goes here
            VStack {
                Text(context.state.currentDisplayTime.asTimestamp)
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // MARK: - Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading: TODO")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing: TODO")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.currentDisplayTime.asTimestamp)
                    // more content
                }
                // MARK: - Island Compact
            } compactLeading: {
                Text("타이머")
            } compactTrailing: {
                Text("B0X")
                // MARK: - minimal
            } minimal: {
                Image(systemName: "timer")
                    .foregroundColor(.blue)
            }
            //.widgetURL(URL(string: "http://www.apple.com"))
            //.keylineTint(Color.red)
        }
    }
}

struct TimerWidgetLiveActivity_Previews: PreviewProvider {
    static let attributes = TimerWidgetAttributes(name: "Me")
    static let contentState = TimerWidgetAttributes.ContentState(currentDisplayTime: 3)

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
