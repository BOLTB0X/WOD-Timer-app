//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    @State private var simpleButton: SimpleButton?
    @State private var showPopup: Bool = false
    
    private let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            VStack(alignment: .leading, spacing: 0) {
                List {
                    // TODO: Right NOW
                    Section(header: Text("Right Now").font(.headline)) {
                        ForEach(simpleArr, id: \.self) { btn in
                            Button(btn.buttonText) {
                                simpleButton = btn
                                showPopup.toggle()
                            }
                            .buttonStyle(EffectButtonStyle())
                        }
                    }
                    
                    // TODO: 지난것들
                    Section(header: Text("Fast Start").font(.headline)) {
                        
                    }
                }
            }
            .navigationTitle("WOD / Interval")
            .navigationBarTitleDisplayMode(.inline)
            .popupNavigationView(show: $showPopup) {
                RoundSet()
                     .navigationBarTitleDisplayMode(.inline)
                     .popupToolbar {
                         showPopup.toggle()
                     }
            }
        }
    }
}

#Preview {
    WodInterView()
}
