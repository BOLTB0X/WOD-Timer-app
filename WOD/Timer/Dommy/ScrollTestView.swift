//
//  ScrollTestView.swift
//  Timer
//
//  Created by lkh on 12/21/23.
//

import SwiftUI

struct ScrollTestView: View {
    @State private var textFieldText: String = ""
    @State private var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    LazyHStack {
                        ForEach(0..<50) { index in
                            Text("This is item #\(index)")
                                .font(.headline)
                                .frame(width: 200, height: 200)  // Adjust the width as needed
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .padding()
                                .id(index)
                        }
                    }
                    .onChange(of: scrollToIndex) { value in
                        proxy.scrollTo(value, anchor: .center)
                    }
                }
            }
        }
    }
}

struct ScrollTestView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTestView()
    }
}
