//
//  TView.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct RealTime: View {
    var time: String
    var fontSize: CGFloat?
    
    var body: some View {
        Text(time)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(
                .system(size: fontSize ?? 24)
                .weight(.bold)
                .monospacedDigit()
            )
    }
}

#Preview {
    Group {
        RealTime(time: "23:45")
            .previewLayout(.sizeThatFits)
        //.preferredColorScheme(.dark)
        
        RealTime(time: "01:23:45", fontSize: 90)
            .previewLayout(.sizeThatFits)
        //.preferredColorScheme(.dark)
        
        RealTime(time: "23:45", fontSize: 125)
            .previewLayout(.sizeThatFits)
    }
}
