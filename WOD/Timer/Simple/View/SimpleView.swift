//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct SimpleView: View {
    // MARK: - class
    @ObservedObject private var viewModel = SimpleViewModel.shared
    
    // MARK: - view 프로퍼티
    @State private var simpleButton: SimpleButton?
    @State private var isSimpleStart: Bool = false
    @State private var showPopup: Bool = false
    @State private var isStartBtn: Bool = false
    
    private let simpleArr: [SimpleButton] = [.round, .preparation, .movements, .rest]
    
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            // MARK: - main
            VStack(alignment: .leading, spacing: 0) {
                List {
                    // MARK: - Simple
                    Section(header: Text("Simple").font(.headline)) {
                        ForEach(simpleArr, id: \.self) { btn in
                            settingButtonRow(btn)
                        }
                        
                        Button("Start") {
                            isStartBtn.toggle()
                        }
                        .buttonStyle(BlueButtonStyle())
                    }
                    
                    // TODO: Detail
                    Section(header: Text("My Set").font(.headline)) {
                        
                    }
                }
            }
            .navigationTitle("WOD / Interval (Simple Set)")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: - 팝업
            .popupNavigationView(show: $showPopup) {
                displayPopup()
                    .environmentObject(viewModel)
            }
            
            // MARK: - 경고창
            .alert(isPresented: $isStartBtn) {
                Alert(
                    title: Text("Confirm"),
                    message: Text(viewModel.confirmationMessage)
                        .font(.subheadline),
                    primaryButton: .default(Text("Start")) {
                        viewModel.createSimpleRounds()
                        isSimpleStart.toggle()
                    },
                    secondaryButton: .cancel(Text("Cancel").foregroundColor(.secondary))
                )
            }
            // MARK: - 모달 뷰
            .fullScreenCover(isPresented: $isSimpleStart) {
                SimpleTimerView(isBackRootView: $isSimpleStart).environmentObject(viewModel)
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    // MARK: - ViewBuilder
    // ..
    // MARK: - settingButtonRow
    @ViewBuilder
    private func settingButtonRow(_ btn: SimpleButton) -> some View {
        Button(action: {
            simpleButton = btn
            showPopup.toggle()
        }, label: {
            HStack(alignment: .center, spacing: 0) {
                Text(btn.buttonText)
                Spacer()
                Text(viewModel.displaySimpleSetValue(btn.buttonText))
            }
            .contentShape(Rectangle())
        })
        .buttonStyle(EffectButtonStyle())
    }
    
    // MARK: - displayPopup
    @ViewBuilder
    private func displayPopup() -> some View {
        switch simpleButton {
        case .round:
            RoundSet(showPopup: $showPopup)
        case .preparation:
            PreparationSet(showPopup: $showPopup)
        case .movements:
            MovementsSet(showPopup: $showPopup)
        default:
            RestSet(showPopup: $showPopup)
        }
    }
}

#Preview {
    SimpleView()
        .environment(\.colorScheme, .dark)
}
