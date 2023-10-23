//
//  TmpView.swift
//  WOD
//
//  Created by KyungHeon Lee on 2023/10/22.
//

import SwiftUI

struct TmpView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var timeRemaining: Double = 20
    @State private var startTime = Date.now
    @State private var shouldNavigate = false

    var body: some View {
        NavigationView { // NavigationView를 이 뷰의 상위에 추가
            VStack {
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
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else {
                        timer.invalidate()
                        shouldNavigate = true
                    }
                })
            }
            .background( // 여기에 NavigationLink를 추가
                NavigationLink("", destination: SecondView(), isActive: $shouldNavigate)
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
