//
//  TimerView.swift
//  TImerB0X
//
//  Created by KyungHeon Lee on 2023/10/25.
//

import SwiftUI

struct TimerView: View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        Text("Timer")
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
