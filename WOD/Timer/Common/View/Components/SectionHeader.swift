//
//  SimpleHeader.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SectionHeader
struct SectionHeader: View {
    // MARK: Binding
    @Binding var idx: Int
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            VStack {
                Text(idx == 0 ? "Timer" : "StopWatch")
                    .font(.headline)
                //.padding(.leading)
            } // VStack
            .fixedSize(horizontal: false, vertical: true)

            Spacer()

            SegmentedButton(selectedIndex: $idx, options: ["hourglass", "stopwatch"])
                //.padding(.trailing)
                .frame(width: 100)
                .fixedSize(horizontal: false, vertical: true)

            
        } // HStack
        .frame(minWidth: 300)
    } // body
}

struct SimpleHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(idx: .constant(0))
    }
}
