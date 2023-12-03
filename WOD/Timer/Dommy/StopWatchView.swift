//
//  TimerView.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct StopWatchView: View {
    @ObservedObject var timerviewModel = StopWatchViewModel()
    
    var body: some View {
        VStack {
            RealTime(time: timerviewModel.manager.elapsedSec, fontSize: 90)
            
            List(timerviewModel.manager.lapTimes, id: \.self) { lapTime in
                Text(lapTime)
            }
            
            HStack {
                RecordButton(mode: timerviewModel.mode, action: timerviewModel.viewTimerRecord)
                
                PlayButton(mode: timerviewModel.mode, action: timerviewModel.viewTimerStartOrPause)
                
                Color.clear
            }
            .padding(.horizontal)
            .frame(height: 150)
        }
    }
}

#Preview {
    StopWatchView()

}
