//
//  TimerWidget.swift
//  TimerWidget
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        // 0.1초 간격으로
        let entryDate = Calendar.current.date(byAdding: .nanosecond, value: 1000000000, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, configuration: configuration)
        entries.append(entry)
        //        for hourOffset in 0 ..< 5 {
        //            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        //            let entry = SimpleEntry(date: entryDate, configuration: configuration)
        //            entries.append(entry)
        //        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct TimerWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct TimerWidget: Widget {
    let kind: String = "TimerWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TimerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TimerWidget_Previews: PreviewProvider {
    static var previews: some View {
        TimerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
