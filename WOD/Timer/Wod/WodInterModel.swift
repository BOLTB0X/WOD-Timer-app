//
//  WodInterModel.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import Foundation

struct WodInterModel: Identifiable {
    let id = UUID()
    var wiName: String
    var setCount: String
    var preparation: String
    var wiDetail: [WodInterDetail]
    var totalTime: String
}

struct WodInterDetail: Identifiable {
    let id = UUID()
    var name: String
    var wiTime: String
    var timer: Timer
}

struct WodInterTimer {
    var secElapsed: Double // 이번엔 떨어지게
    
    // view에서 사용할 변수들
    var elapsedSec: String { // 경과시간(ms)를 문자열(mm:ss.SS)로 저장
        timeToString(secElapsed)
    }
    
    private func timeToString(_ t: Double) -> String {
        let sec = Int(t)
        let minu = sec / 60
        let frac = Int((t - Double(sec)) * 100)
        return String(format: "%02d:%02d.%02d", minu, sec % 60, frac)
    }
}
