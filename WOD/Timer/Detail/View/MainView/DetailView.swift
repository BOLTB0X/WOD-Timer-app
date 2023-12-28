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
    @State private var isModeBtn: Int = 0 // 0 = timer, 1 = stopwatch
    
    // MARK: - View
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    // MARK: - Routine
                    Section(header: SectionHeader(idx: $isModeBtn)) {
                        ForEach(viewModel.detailButtonType, id: \.self) { btn in
                            DetailButtonSetRow(detailButton: $detailButton, showPopup: $showPopup, rootView: $rootView, isModeBtn: $isModeBtn, viewModel: viewModel, btn: btn)
                        } // ForEach
                        .listStyle(SidebarListStyle())
                    } // Section
                    
                    // TODO: - My Set, Coredata
                    Section(header: Text("My Set").font(.headline)) {
                        
                    } // Routine(My Set)
                } // Form
                
                // 이동
                NavigationLink(
                    destination: DetailTimerCycleSet(rootView: $rootView)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(),
                    isActive: $rootView) {
                        EmptyView()
                    }
                
            } // VStack
            .navigationTitle("Detail Routine")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: - popupNavigationView
            // 팝업
            .popupNavigationView(show: $showPopup) {
                displayPopup()
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
        default:
            DetailTimerRestSet(showPopup: $showPopup)
                .environmentObject(viewModel)
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
