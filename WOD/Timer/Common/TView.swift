//
//  TView.swift
//  Timer
//
//  Created by lkh on 10/26/23.
//

import SwiftUI

struct TView: View {
    var time: String
    var fontSize: CGFloat?
    
    var body: some View {
            Text(time)
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .font(
                    .system(size: fontSize ?? 24) // 폰트 크기를 조절, 기본 크기는 24
                        .weight(.bold)
                        .monospacedDigit()
                    
                )
    }
}

#Preview {
    Group {
        TView(time: "23:45")
            .previewLayout(.sizeThatFits)
            //.preferredColorScheme(.dark)
        
        TView(time: "01:23:45", fontSize: 90)
            .previewLayout(.sizeThatFits)
            //.preferredColorScheme(.dark)
    }
}
