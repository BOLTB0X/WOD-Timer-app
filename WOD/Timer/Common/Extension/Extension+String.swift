//
//  Extension+String.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import Foundation

extension String {
    static func timeToString(_ t: Double) -> String {
        let sec = Int(t)
        let minu = sec / 60
        let frac = Int((t - Double(sec)) * 100)
        return String(format: "%02d:%02d.%02d", minu, sec % 60, frac)
    }
}
