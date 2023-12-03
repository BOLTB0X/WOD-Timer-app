//
//  CircularProgress.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import SwiftUI

struct CircularProgress: View {
    @Binding var progress: Float

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8.0)
                .opacity(0.1)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 30.0,
                    lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
        }
        .animation(.linear(duration: 1.0), value: progress)
    }
}

#Preview {
    CircularProgress(progress: .constant(0.0))
}
