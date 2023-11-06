//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            VStack(alignment: .center, spacing: 0) {
                //TimeSettingView()
                Form {
                    Section(header: Text("WOD / Interval Set").font(.headline)) {
                        VStack(alignment: .leading, spacing: 30) {
                            NavigationLink("New Set", destination: WodSet())
                            
                            NavigationLink("Simple Set", destination: SimpleSet())
                        }
                        
                    }
                    
                    // TODO: Edit
                    Section(header: Text("My Set").font(.headline)) {
                        
                    }
                    
                    // TODO: 지난것들
                    Section(header: Text("Fast Start").font(.headline)) {
                        
                    }
                }
                
            }
            .navigationTitle("WOD / Interval")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    WodInterView()
}
