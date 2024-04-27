//
//  LockScreenLiveActivityView.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/04/22.
//

import SwiftUI
import ActivityKit
import WidgetKit

// MARK: - LockScreenLiveActivityView
struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<TimerWidgetAttributes>
    
    // MARK: - View
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                HStack(alignment: .center) {
                    Image(systemName: "hourglass.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                    
                    Text("WOD B0X")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    if context.state.currentState != "Completed" {
                        Text("\(context.state.currentRound)R:")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .monospaced()
                        
                    } else {
                        Text("All")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .monospaced()
                    }
                    
                    Spacer()
                    
                    Text("\(context.state.currentState)")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .monospaced()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .monospaced()
                
                Spacer()
            }
            
            Text(context.state.currentDisplayTime.asTimestamp)
                .font(.system(size: 40, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .monospaced()
        }
        .padding(.horizontal)
        .fixedSize(horizontal: true, vertical: true)
    } // body
}
