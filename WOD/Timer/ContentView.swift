//
//  ContentView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainView()
    }
}

struct btnCustom: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(Color.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
