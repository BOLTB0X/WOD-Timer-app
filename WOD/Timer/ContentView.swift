//
//  ContentView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView {
            SimpleView()
                .tabItem {
                    Image(systemName: "figure.highintensity.intervaltraining")
                }
            
            StopWatchView()
                .tabItem {
                    Image(systemName: "timer")
                }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

