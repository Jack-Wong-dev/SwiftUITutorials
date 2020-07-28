//
//  DesignCodeWidgit.swift
//  DesignCodeWidgit
//
//  Created by Jack Wong on 7/28/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct DesignCodeWidgitEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        if family == .systemSmall {
            DesignCodeWidgetSmall()
        } else {
            DesignCodeWidgetMedium()
        }
    }
}

struct DesignCodeWidgetSmall: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            Text("Matched Geometry Effect")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("learn how to quickly transition different views")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(12)
    }
}

struct DesignCodeWidgetMedium: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            ForEach(courseSections.indices) { index in
                if index < 2 {
                    CourseRow()
                }
            }
        }
        .padding(12)
    }
}


@main
struct DesignCodeWidgit: Widget {
    private let kind: String = "DesignCodeWidgit"
    
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            DesignCodeWidgitEntryView(entry: entry)
        }
        .configurationDisplayName("DesignCode")
        .description("Lateste courses and tutorials.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct DesignCodeWidgit_Previews: PreviewProvider {
    static var previews: some View {
        DesignCodeWidgitEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
