//
//  DetailView.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailView
struct DetailView: View {
    // MARK: Object
    @ObservedObject private var viewModel = DetailViewModel.shared
    
    // MARK: State
    // 모드, 각 셋팅 관련
    @State private var isModeBtn: Int = 0
    @State private var detailButton: DetailButton?
    @State private var showPopup: Bool = false
    @State private var rootView: Bool = false
    
    // 타이머/스톱워치 실행 관련
    @State private var isDetailStart: Bool = false
    @State private var isStartBtn: Bool = false
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Set
                Section(header: SectionHeader(idx: $isModeBtn)) {
                    ForEach(viewModel.detailButtonType, id: \.self) { btn in
                        rootRow(btn)
                    } // ForEach
                    
                    Button("Start") {
                        isStartBtn.toggle()
                    }
                    .buttonStyle(BlueButtonStyle())
                } // Section
                
                // TODO: - My Set, Coredata
                Section(header: Text("My Set").font(.headline)) {
                    
                } // WOD(My Set)
            } // Form
            .listStyle(SidebarListStyle())
            .navigationTitle("Detail Set")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: side
            // ...
            // MARK: - navigationDestination
            .navigationDestination(isPresented: $rootView) {
                DetailLoopView(rootView: $rootView, modeBtn: $isModeBtn)
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden()
            }
            
            // MARK: - popupNavigationView
            // 팝업
            .popupNavigationView(show: $showPopup) {
                displayPopup()
            }
            
            // MARK: - alert
            // 경고창
            .alert(isPresented: $isStartBtn) {
                Alert(
                    title: Text("Confirm").bold(),
                    message: Text(isModeBtn == 0 ? viewModel.confirmationMessage : viewModel.confirmationMessageStop)
                        .font(.subheadline),
                    primaryButton: .default(Text("Start")) {
                        buttonAction()
                    },
                    secondaryButton: .destructive(Text("Cancel"))
                )
            }
            
            // MARK: - fullScreenCover
            // 모달뷰
            .fullScreenCover(isPresented: $isDetailStart) {
                goFullScreenCover()
            }
            
        } // NavigationView
        
        .onTapGesture {
            self.hideKeyboard()
        }
    }// body
    
    // MARK: - ViewBuilder
    // ...
    // MARK: rootRow
    @ViewBuilder
    private func rootRow(_ btn: DetailButton) -> some View {
        HStack(alignment: .center, spacing: 15) {
            DetailImageSetRow(
                detailButton: $detailButton,
                showPopup: $showPopup,
                preparationColor: isModeBtn == 0 ? $viewModel.timerPreparationColor : $viewModel.stopPreparationColor,
                loopRestColor: isModeBtn == 0 ? $viewModel.timerRestColor : $viewModel.stopRestColor,
                btn: btn)
            
            DetailButtonSetRow(
                detailButton: $detailButton,
                showPopup: $showPopup,
                rootView: $rootView,
                isModeBtn: $isModeBtn,
                viewModel: viewModel,
                btn: btn)
        } // HStack
    } // rootRow
    
    // MARK: - displayPopup
    @ViewBuilder
    private func displayPopup() -> some View {
        if isModeBtn == 0 {
            switch detailButton {
            case .preparation:
                DeatilTimerPreparationSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .round:
                DetailTimerRoundSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .preparationColor:
                DeatilTimerPreparationColorSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .loopRestColor:
                DetailTimerRestColorSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            default:
                DetailTimerRestSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            }
        } else {
            switch detailButton {
            case .preparation:
                DetailStopwatchPreparationSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .round:
                DetailStopwatchRoundSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .preparationColor:
                DeatilStopwatchPreparationColorSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .loopRestColor:
                DetailStopwatchRestColorSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            default:
                DetailTimerRestSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            }
        }
    } // displayPopup
    
    // MARK: - goFullScreenCover
    @ViewBuilder
    private func goFullScreenCover() -> some View {
        if isModeBtn == 0 { // Timer
            DetailTimerView(isBackRootView: $isDetailStart)
                .environmentObject(viewModel)
        } else {
            DetailStopwatchView(isBackRootView: $isDetailStart)
                .environmentObject(viewModel)
        } // if - else
    } // goFullScreenCover
    
    // MARK: - Methods
    // ...
    // MARK: - buttonAction
    private func buttonAction() {
        if isModeBtn == 0 {
            viewModel.createDetailTimerRounds()
        } else {
            viewModel.createDetailStopRounds()
        }
        isDetailStart.toggle()
    } // buttonAction
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
