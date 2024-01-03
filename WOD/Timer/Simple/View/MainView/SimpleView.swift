//
//  WodInterView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

// MARK: - SimpleView
// 간단하게 타이머 루틴 or 스톱워치 루틴을 설정하는 뷰
struct SimpleView: View {
    // MARK: Object
    @ObservedObject private var viewModel = SimpleViewModel.shared
    
    // MARK: State
    @State private var simpleButton: SimpleButton?
    @State private var isSimpleStart: Bool = false
    @State private var showPopup: Bool = false
    @State private var isStartBtn: Bool = false
    @State private var isModeBtn: Int = 0 // 0 = timer, 1 = stopwatch
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Form {
                    // MARK: - Set
                    Section(header: SectionHeader(idx: $isModeBtn)) {
                        ForEach(viewModel.simpleButtonType, id: \.self) { btn in
                            SimpleButtonSetRow(
                                simpleButton: $simpleButton,
                                showPopup: $showPopup,
                                isModeBtn: $isModeBtn,
                                viewModel: viewModel,
                                btn: btn)
                        } // ForEach
                        Button("Start") {
                            isStartBtn.toggle()
                        }
                        .buttonStyle(BlueButtonStyle())
                    } // Routine(Section)
                    
                    // TODO: - My Set, Coredata
                    Section(header: Text("My Set").font(.headline)) {
                        
                    } // Routine(My Set)
                } // Form
            } // VStack
            .navigationTitle("Simple Set")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: side
            // MARK: - popupNavigationView
            // 팝업
            .popupNavigationView(show: $showPopup) {
                displayPopup()
                    .environmentObject(viewModel)
            }
            
            // MARK: - alert
            // 경고창
            .alert(isPresented: $isStartBtn) {
                Alert(
                    title: Text("Confirm").bold(),
                    message: Text(isModeBtn == 0 ? viewModel.confirmationMessage: viewModel.confirmationStopMessage)
                        .font(.subheadline),
                    primaryButton: .default(Text("Start")) {
                        buttonAction()
                    },
                    secondaryButton: .destructive(Text("Cancel").foregroundColor(.secondary))
                )
            }
            
            // MARK: - fullScreenCover
            // 모달뷰
            .fullScreenCover(isPresented: $isSimpleStart) {
                goFullScreenCover()
            }
        } // NavigationView
        .onTapGesture {
            self.hideKeyboard()
        }
    } // body
    
    // MARK: - ViewBuilder
    // ...
    // MARK: - displayPopup
    @ViewBuilder
    private func displayPopup() -> some View {
        if isModeBtn == 0 { // Timer
            switch simpleButton {
            case .round:
                SimpleTimerRoundSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .preparation:
                SimpleTimerPreparationSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .movements:
                SimpleTimerMovementsSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            default:
                SimpleTimerRestSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            }
        } else { // 스톱워치
            if simpleButton == .round {
                SimpleRoundStopSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            } else if simpleButton == .preparation {
                SimpleStopwatchPreparationSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            }
        } // if - else
    } // displayPopup
    
    // MARK: - goFullScreenCover
    @ViewBuilder
    private func goFullScreenCover() -> some View {
        if isModeBtn == 0 { // Timer
            SimpleTimerView(isBackRootView: $isSimpleStart)
                .environmentObject(viewModel)
        } else {
            SimpleStopWatchView(isBackRootView: $isSimpleStart)
                .environmentObject(viewModel)
        } // if - else
    } // goFullScreenCover
    
    // MARK: - Methods
    // ...
    // MARK: - buttonAction
    private func buttonAction() {
        if isModeBtn == 0 {
            viewModel.createSimpleTimerRounds()
        } else {
            viewModel.createSimpleStopRounds()
        }
        isSimpleStart.toggle()
    } // buttonAction
}

struct SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleView()
        .environment(\.colorScheme, .dark)
    }
}
