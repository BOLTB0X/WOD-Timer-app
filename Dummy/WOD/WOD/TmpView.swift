//
//  TmpView.swift
//  WOD
//
//  Created by KyungHeon Lee on 2023/10/22.
//

import SwiftUI

struct TmpView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State var timeList = [
        tmpModel(name: "A", StartTime: Date.now, limitTime: 10, flag: false),
        tmpModel(name: "B", StartTime: Date.now, limitTime: 10, flag: false),
        tmpModel(name: "C", StartTime: Date.now, limitTime: 10, flag: false)
    ]
    
    @State private var timeRemaining: Double = 20
    @State private var startTime = Date.now
    @State private var naviFlag = false
    
    var body: some View {
        NavigationView { // NavigationView를 이 뷰의 상위에 추가
            VStack {
                List(timeList, id: \.name) { time in
                    HStack {
                        Text(time.name)
                        Text(getTimeString(time: timeRemaining))
                            .onChange(of: scenePhase) { newValue in
                                switch newValue {
                                case .active:
                                    print("Active")
                                case .inactive:
                                    print("Inactive")
                                case .background:
                                    print("Background")
                                    bgTimer()
                                default:
                                    print("scenePhase err")
                                }
                            }
                    }
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else {
                        timer.invalidate()
                        naviFlag = true
                    }
                })
            }
            .background(
                NavigationLink("", destination: SecondView(), isActive: $naviFlag)
            )
        }
    }
    
    func getTimeString(time: Double) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func bgTimer() {
        let curTime = Date.now
        let diffTime = curTime.distance(to: startTime)
        let result = Double(diffTime.formatted())!
        timeRemaining = 20 + result
        
        if timeRemaining < 0 {
            timeRemaining = 0
        }
    }
}


struct SecondView: View {
    var body: some View {
        Text("다른 뷰로 이동~~")
    }
}

struct TmpView_Previews: PreviewProvider {
    static var previews: some View {
        TmpView()
    }
}
