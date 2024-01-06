//
//  TView.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

// MARK: - RealTime
struct RealTime: View {
    // MARK: 프로퍼티
    var time: String
    var fontSize: CGFloat?
    
    // MARK: - View
    var body: some View {
        Text(time)
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(
                .system(size: fontSize ?? 24, weight: .heavy)
            )
            .monospacedDigit()
    }
}

struct RealTime_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RealTime(time: "23:45")
                .previewLayout(.sizeThatFits)
            //.preferredColorScheme(.dark)
            
            RealTime(time: "01:23:45", fontSize: 85)
                .previewLayout(.sizeThatFits)
            //.preferredColorScheme(.dark)
            
            RealTime(time: "23:45", fontSize: 125)
                .previewLayout(.sizeThatFits)
        }
    }
    
}

