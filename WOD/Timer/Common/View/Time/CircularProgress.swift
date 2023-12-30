//
//  CircularProgress.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import SwiftUI

// MARK: - CircularProgress
struct CircularProgress: View {
    // MARK: Binding
    @Binding var progress: Float
    
    // MARK: - View
    var body: some View {
        // MARK: main
        ZStack {
            Circle()
                .stroke(lineWidth: 8.0)
                .opacity(0.1)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0,
                    lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .foregroundColor(Color(.systemBlue))
        } // ZStack
        
        // MARK: side
        .animation(progress == 0.0 ? nil : .linear(duration: 1.0), value: progress)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct CircularProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgress(progress: .constant(0.0))
    }

}
