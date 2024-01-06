//
//  ContentView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    // MARK: State
    @State var selectedTab = 0
    
    // MARK: - View
    var body: some View {
        TabView {
            SimpleView()
                .tabItem {
                    Text("Simple")
                }
            
            DetailView()
                .tabItem {
                    Text("Detail")
                }
        } // TabView
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

