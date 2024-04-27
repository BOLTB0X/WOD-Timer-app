//
//  ExpandedLiveActivityView.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/04/25.
//

import SwiftUI
import ActivityKit
import WidgetKit

// MARK: - ExpandedLiveActivityView
struct ExpandedLiveActivityView: View {
    let context: ActivityViewContext<TimerWidgetAttributes>
    // MARK: - View
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                HStack {
                    Spacer()
                    
                    Text(context.state.currentState)
                        .bold()
                        .font(.system(size: 30, weight: .semibold))
                        .monospacedDigit()
                    
                    Spacer()
                    
                    Text(context.state.currentDisplayTime.asTimestamp)
                        .font(.system(size: 30, weight: .bold))
                        .fontWeight(.bold)
                        .monospaced()
                    
                    Spacer()
                }
            }
            HStack {
                Link(destination: URL(string: "WODB0X://before")!, label: {
                    Image(systemName: "backward.end.fill")
                        .resizable()
                        .frame(width: 20 , height: 20)
                    
                        .foregroundColor(.white)
                })
                .environment(\.openURL, OpenURLAction { url in
                    print("\(url)")
                    return .handled
                })
                .padding(.horizontal)
                
                Link(destination: URL(string: "WODB0X://stopResume")!, label: {
                    Image(systemName: "playpause.circle.fill")
                        .resizable()
                        .frame(width: 40 , height: 30)
                        .foregroundColor(.white)
                })
                .environment(\.openURL, OpenURLAction { url in
                    print("\(url)")
                    return .handled
                })
                .padding(.horizontal)
                
                Link(destination: URL(string: "WODB0X://next")!, label: {
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .frame(width: 20 , height: 20)
                        .foregroundColor(.white)
                    
                })
                .environment(\.openURL, OpenURLAction { url in
                    print("\(url)")
                    return .handled
                })
                .padding(.horizontal)
                
            }
        }
    }
}
