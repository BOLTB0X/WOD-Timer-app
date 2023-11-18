//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct WodInterView: View {
    // MARK: - class
    @ObservedObject private var viewModel = WodViewModel.shared
    @StateObject var simpleTimer = SimpleTimerManager.shared
    
    // MARK: - view 프로퍼티
    @State private var simpleButton: SimpleButton?
    @State private var showPopup: Bool = false
    @State private var isChange: Bool = false
    @State private var isStartBtn: Bool = false
    
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            VStack(alignment: .leading, spacing: 0) {
                List {
                    // TODO: Simple NOW
                    Section(header: Text("Simple").font(.headline)) {
                        ForEach(viewModel.simpleArr, id: \.self) { btn in
                                Button(btn.buttonText) {
                                    simpleButton = btn
                                    showPopup.toggle()
                                }
                                .buttonStyle(EffectButtonStyle(
                                    text: viewModel.displaySetValue(btn.buttonText)))
                        }
                        Button("Start") {
                            isStartBtn.toggle()
                        }
                        .buttonStyle(BlueButtonStyle())
                    }
                    
                    
                    // TODO: 지난것들
                    Section(header: Text("Detail").font(.headline)) {
                        
                    }
                }
                NavigationLink(destination: SimpleTimerView(), isActive: $viewModel.isSimpleStart) {
                            EmptyView()
                        }
                        .hidden()
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
            .alert(isPresented: $isStartBtn) {
                Alert(
                    title: Text("Confirm"),
                    message: Text("Are you sure you want to start?"),
                    primaryButton: .default(Text("Start")) {
                        viewModel.simpleStartButtonTouchd()
                        viewModel.isSimpleStart.toggle()
                    },
                    secondaryButton: .cancel(Text("Cancel"))
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
