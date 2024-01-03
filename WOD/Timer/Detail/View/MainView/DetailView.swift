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
    @State private var detailButton: DetailButton?
    @State private var isDetailStart: Bool = false
    @State private var showPopup: Bool = false
    @State private var rootView: Bool = false
    @State private var isModeBtn: Int = 0
    @State private var isStartBtn: Bool = false
    
    // MARK: - View
    var body: some View {
        NavigationView {
            // MARK: main
            // ...
            VStack(alignment: .center, spacing: 0) {
                Form {
                    // MARK: - Set
                    Section(header: SectionHeader(idx: $isModeBtn)) {
                        ForEach(viewModel.detailButtonType, id: \.self) { btn in
                            HStack(alignment: .center, spacing: 15) {
                                DetailImageSetRow(detailButton: $detailButton, showPopup: $showPopup, isMode: $isModeBtn, preparationColor: $viewModel.timerPreparationColor, loopRestColor: $viewModel.timerLoopRestColor,
                                                  btn: btn)
                                
                                DetailButtonSetRow(
                                    detailButton: $detailButton,
                                    showPopup: $showPopup,
                                    rootView: $rootView,
                                    isModeBtn: $isModeBtn,
                                    viewModel: viewModel,
                                    btn: btn)
                            } // HStack
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
                
                // 이동
                NavigationLink(
                    destination: DetailTimerLoopView(rootView: $rootView)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(),
                    isActive: $rootView
                ) {
                    EmptyView()
                }
            } // VStack
            .navigationTitle("Detail Set")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: side
            // ...
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
                    message: Text(viewModel.confirmationMessage)
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
    // MARK: - displayPopup
    @ViewBuilder
    private func displayPopup() -> some View {
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
    } // displayPopup
    
    // MARK: - goFullScreenCover
    @ViewBuilder
    private func goFullScreenCover() -> some View {
        if isModeBtn == 0 { // Timer
            DetailTimerView(isBackRootView: $isDetailStart)
                .environmentObject(viewModel)
        } else {
            
        } // if - else
    } // goFullScreenCover
    
    // MARK: - Methods
    // ...
    // MARK: - buttonAction
    private func buttonAction() {
        if isModeBtn == 0 {
            viewModel.createDetailTimerRounds()
        } else {
            
        }
        isDetailStart.toggle()
    } // buttonAction
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
