//
//  HorizontalScroll.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - SimpleHorizontalScroll
struct SimpleHorizontalScroll: View {
    @Binding var scrollLastIndex: Int?
    @Binding var scrollList: [SimpleRound]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                if let idx = scrollLastIndex {
                    ScrollViewReader { proxy in
                        LazyHStack {
                            ForEach(scrollList.indices) { idx in
                                CardCell(title: "\(idx) Round", text1: "Movements", subText1: scrollList[idx].movement.asTimestamp, text2: "Rest", subText2: scrollList[idx].rest.asTimestamp)
                                //                            VStack(alignment: .center, spacing: 0) {
                                //                                Text("\(idx) Round")
                                //                                    .font(.title)
                                //                                HStack(alignment: .center, spacing: 0) {
                                //                                    Text("Movements:\n\(scrollList[idx].movement.asTimestamp)")
                                //                                    Spacer()
                                //                                    Text("Rest:\n\(scrollList[idx].rest.asTimestamp)")
                                //                                } // HStack
                                //                            } // VStack
                                //                            .frame(height: 100)
                                    .frame(width: geometry.size.width, height: geometry.size.height)                                //                            .cornerRadius(10)
                                //                            .shadow(radius: 10)
                                    .padding()
                                    .id(idx)
                                
                            } // ForEach
                        } // LazyHStack
                        .onChange(of: scrollLastIndex) { value in
                            proxy.scrollTo(value, anchor: .center)
                        }
                    } // ScrollViewReader
                    .onAppear {
                        UIScrollView.appearance().isPagingEnabled = true
                    }
                } else {
                    Spacer()
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                }
            } // ScrollView
        }
    } // body
}
