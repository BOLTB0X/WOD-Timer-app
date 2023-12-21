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
    // MARK: - class 프로퍼티
    @ObservedObject private var viewModel = SimpleViewModel.shared
    
    // MARK: - only View 프로퍼티s
    @State private var simpleButton: SimpleButton?
    @State private var isSimpleStart: Bool = false
    @State private var showPopup: Bool = false
    @State private var isStartBtn: Bool = false
    @State private var isModeBtn: Int = 0 // 0 = timer, 1 = stopwatch
    
    var body: some View {
        NavigationView { // for navigationTitle 이용 및 뷰 구성
            // MARK: - main
            VStack(alignment: .leading, spacing: 0) {
                Form {
                    // MARK: - Routine
                    Section(header: SimpleHeader(idx: $isModeBtn)) {
                        ForEach(viewModel.simpleButtonType, id: \.self) { btn in
                            SimpleButtonSetRow(simpleButton: $simpleButton, 
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
            .navigationTitle("Simple Routine")
            .navigationBarTitleDisplayMode(.inline)
            
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
                        if isModeBtn == 0 {
                            viewModel.createSimpleTimerRounds()
                        } else {
                            viewModel.createSimpleStopRounds()
                        }
                        isSimpleStart.toggle()
                    },
                    secondaryButton: .cancel(Text("Cancel").foregroundColor(.secondary))
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
                SimpleTimerPreparationStopSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            }
        }
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
        }
    } // goFullScreenCover
    
}

struct SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleView()
        .environment(\.colorScheme, .dark)
    }
}
