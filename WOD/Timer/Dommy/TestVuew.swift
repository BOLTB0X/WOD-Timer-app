//
//  TestVuew.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187)) // 1
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true) // 2
            }
            .fill(.purple)
            .offset(x: 20, y: 20)
            
            Path { path in
                path.move(to: CGPoint(x: 187, y: 187)) // 3
                path.addArc(center: CGPoint(x: 187, y: 187), radius: 150, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true) //4
                
                path.closeSubpath()
            }
            .stroke(.black, lineWidth: 10)
            .offset(x: 20, y: 20)
        }
    }
}

#Preview {
    TestView()
}
