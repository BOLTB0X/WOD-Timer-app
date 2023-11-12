//
//  MainView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView {
            WodInterView()
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

