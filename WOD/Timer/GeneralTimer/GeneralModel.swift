//
//  TimerModel.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import Foundation

struct GeneralModel {
    var secElapsed: Double // 타이머 초 경과 시간
    var lapElapsed: Double // 랩 경과 시간
    var lapTimes: [String]
    
    init() {
        secElapsed = 0
        lapElapsed = 0
        lapTimes = []
    }
    
    init(secElapsed: Double, lapElapsed: Double, lapTimes: [String]) {
        self.secElapsed = secElapsed
        self.lapElapsed = lapElapsed
        self.lapTimes = lapTimes
    }
    
    // view에서 사용할 변수들
    var elapsedSec: String { // 경과시간(ms)를 문자열(mm:ss.SS)로 저장
        timeToString(secElapsed)
    }
    
    var selectedLap: String { // 랩타임 경과시간(ms)를 문자열(mm:ss.SS)로 저장
        timeToString(lapElapsed)
    }
    
    private func timeToString(_ t: Double) -> String {
        let sec = Int(t)
        let minu = sec / 60
        let frac = Int((t - Double(sec)) * 100)
        return String(format: "%02d:%02d.%02d", minu, sec % 60, frac)
    }
}
