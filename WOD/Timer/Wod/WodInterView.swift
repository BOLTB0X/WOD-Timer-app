//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    @ObservedObject private var viewModel = WodViewModel()
    @ObservedObject private var model = WodInterViewModel()
    @State private var simpleButton: SimpleButton?
    @State private var showPopup: Bool = false
    @State private var isChange: Bool = false

        
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
                switch simpleButton {
                case .round:
                    RoundSet(isChange: $isChange)
                        .environmentObject(viewModel)
                        .navigationTitle("Round")
                         .navigationBarTitleDisplayMode(.inline)
                         .popupSettingToolbar(action1:  { showPopup.toggle() }, text: !isChange ? "keyboard" : "wheel", action2: { isChange.toggle() }
                         )
                case .preparation:
                    PreparationSet(isChange: $isChange)
                        .environmentObject(viewModel)
                        .navigationTitle("Preparation")
                        .navigationBarTitleDisplayMode(.inline)
                        .popupSettingToolbar(action1:  { showPopup.toggle() }, text: !isChange ? "keyboard" : "wheel", action2: { isChange.toggle() }
                        )
                case .movements:
                    MovementsSet(isChange: $isChange)
                        .environmentObject(viewModel)
                        .navigationTitle("Movements")
                        .navigationBarTitleDisplayMode(.inline)
                        .popupSettingToolbar(action1:  { showPopup.toggle() }, text: !isChange ? "keyboard" : "wheel", action2: { isChange.toggle() }
                        )

                default:
                    RestSet(isChange: $isChange)
                        .environmentObject(viewModel)
                        .navigationTitle("Rest")
                        .navigationBarTitleDisplayMode(.inline)
                        .popupSettingToolbar(action1:  { showPopup.toggle() }, text: !isChange ? "keyboard" : "wheel", action2: { isChange.toggle() }
                        )
                }
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

#Preview {
    WodInterView()
}
