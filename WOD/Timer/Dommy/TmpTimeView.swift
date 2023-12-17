//
//  TmpTimeView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct TmpTimeView: View {
    @State private var currentTime = 0
    @State private var runnigBtn: Bool = false
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(currentTime)")
                .onReceive(timer) { time in
                    if runnigBtn {
                        currentTime += 1
                    }
                }
            Button(action: {
                runnigBtn.toggle()
            }) {
                Image(systemName: runnigBtn ? "pause.circle" : "play.circle")
                    .font(.system(size: 50))
            }
            .padding()
        }
        .padding()
    }
}
