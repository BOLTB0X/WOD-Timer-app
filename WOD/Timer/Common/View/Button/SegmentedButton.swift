//
//  SegmentedButton.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

struct SegmentedButtonTest: View {
    @State var preselectedIndex = 0
    
    var body: some View {
        SegmentedButton(selectedIndex: $preselectedIndex, options: ["hourglass", "stopwatch"])
    }
}

// MARK: - SegmentedButton
struct SegmentedButton: View {
    // MARK: Binding
    @Binding var selectedIndex: Int
    
    // MARK: 프로퍼티s
    var options: [String]
    let color = Color("lightBlue1")
    
    // MARK: View
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.2))
                    
                    Rectangle()
                        .fill(color)
                        .cornerRadius(10)
                        .padding(2)
                        .opacity(selectedIndex == index ? 1 : 0.01)
                } // ZStack
                .overlay(
                    Button(action: {
                        selectedIndex = index
                    }, label: {
                        Image(systemName:options[index])
                            .foregroundColor(selectedIndex == index ? .black : .white)
                    })
                ) // overlay
            } // ForEach
        } // HStack
        .frame(height: 40)
        .cornerRadius(10)
    }
}

struct SegmentedButton_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedButtonTest()
    }
}
