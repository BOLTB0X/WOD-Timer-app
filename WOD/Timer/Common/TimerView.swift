//
//  TimerView.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerviewMoel: TimerManager
    
    var body: some View {
        VStack {
            TView(time: timerviewMoel.timeManager.elapsedSec, fontSize: 90)
            
            List(timerviewMoel.timeManager.lapTimes, id: \.self) { lapTime in
                Text(lapTime)
            }
            
            HStack {
                RecordButton(mode: timerviewMoel.mode, action: timerviewMoel.viewTimerRecord)
                
                PlayButton(mode: timerviewMoel.mode, action: timerviewMoel.viewTimerStartOrPause)
                
                Color.clear
            }
            .padding(.horizontal)
            .frame(height: 150)
        }
    }
}

#Preview {
    TimerView()
        .environmentObject(TimerManager())
}
