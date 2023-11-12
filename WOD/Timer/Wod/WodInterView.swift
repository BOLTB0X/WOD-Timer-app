//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    @ObservedObject private var viewModel = WodViewModel()
    
    @State private var simpleButton: SimpleButton?
    @State private var showPopup: Bool = false
    @State private var isChange: Bool = false
    
    private let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            VStack(alignment: .leading, spacing: 0) {
                List {
                    // TODO: Simple NOW
                    Section(header: Text("Right Now").font(.headline)) {
                        ForEach(simpleArr, id: \.self) { btn in
                                Button(btn.buttonText) {
                                    simpleButton = btn
                                    showPopup.toggle()
                                }
                                .buttonStyle(EffectButtonStyle(text: viewModel.displaySetValue(btn.buttonText)))
                        }
                    }
                    
                    // TODO: 지난것들
                    Section(header: Text("Detail Setting").font(.headline)) {
                        
                    }
                }
            }
            .navigationTitle("WOD / Interval")
            .navigationBarTitleDisplayMode(.inline)
            .popupNavigationView(show: $showPopup) {
                switchForButton()
                    .environmentObject(viewModel)
                    .navigationBarTitleDisplayMode(.inline)
                    .popupSettingToolbar(action1:  { showPopup.toggle() }, text: !isChange ? "keyboard" : "wheel", action2: { isChange.toggle() }
                    )
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    @ViewBuilder
    private func switchForButton() -> some View {
        switch simpleButton {
        case .round:
            RoundSet(isChange: $isChange)
                .navigationTitle("Round")
        case .preparation:
            PreparationSet(isChange: $isChange)
                .navigationTitle("Preparation")

        case .movements:
            MovementsSet(isChange: $isChange)
                .navigationTitle("Movements")

        default:
            RestSet(isChange: $isChange)
                .navigationTitle("Rest")
        }
    }
}

#Preview {
    WodInterView()
}
