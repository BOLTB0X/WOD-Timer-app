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
            
            DetailView()
                .tabItem {
                    Image(systemName: "timer")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

