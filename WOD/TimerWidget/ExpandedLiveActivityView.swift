//
//  ExpandedLiveActivityView.swift
//  Timer
//
//  Created by KyungHeon Lee on 2024/04/25.
//

import SwiftUI
import UIKit

// MARK: - ExpandedLiveActivityView
struct ExpandedLiveActivityView: View {
    @State private var playOrStop: Bool = false
    
    // MARK: - View
    var body: some View {
        HStack {
            Link(destination: URL(string: "WODB0X://before")!, label: {
                Image(systemName: "backward.end.circle")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.blue)
            })
            .environment(\.openURL, OpenURLAction { url in
                print("The the action to the app with \(url)")
                return .handled
            })
            .padding()
            
            Link(destination: URL(string: "WODB0X://stopResume")!, label: {
                Image(systemName: "playpause.circle.fill")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        playOrStop.toggle()
                    }
                
            })
            .environment(\.openURL, OpenURLAction { url in
                print("The the action to the app with \(url)")
                return .handled
            })
            .padding()
            
            Link(destination: URL(string: "WODB0X://next")!, label: {
                Image(systemName: "forward.end.circle")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.blue)
                
            })
            .environment(\.openURL, OpenURLAction { url in
                print("The the action to the app with \(url)")
                return .handled
            })
            .padding()
            
        }
    }
}

struct ExpandedLiveActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedLiveActivityView()
    }
}
