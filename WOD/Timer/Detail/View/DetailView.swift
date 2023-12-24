//
//  DetailView.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailView
struct DetailView: View {
    // MARK: - class 프로퍼티
    @ObservedObject private var viewModel = DetailViewModel.shared
    
    // MARK: - only View 프로퍼티s
    @State private var detailButton: DetailButton?
    @State private var isDetailStart: Bool = false
    @State private var showPopup: Bool = false
    @State private var rootView: Bool = false
    @State private var isModeBtn: Int = 0 // 0 = timer, 1 = stopwatch
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - Routine
                    Section(header: SectionHeader(idx: $isModeBtn)) {
                        ForEach(viewModel.detailButtonType, id: \.self) { btn in
                            DetailButtonSetRow(detailButton: $detailButton, showPopup: $showPopup, rootView: $rootView, isModeBtn: $isModeBtn, viewModel: viewModel, btn: btn)
                        } // ForEach
                        .listStyle(SidebarListStyle())
                    } // Section
                } // Form
                
                NavigationLink(
                    destination: DetailTimerCycleSet( rootView: $rootView)
                        .environmentObject(viewModel),
                    isActive: $rootView) {
                        EmptyView()
                    }
            }
            .navigationTitle("Detail Routine")
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - popupNavigationView
            // 팝업
            .popupNavigationView(show: $showPopup) {
                
            }
            
        } // NavigationView
        .onTapGesture {
            self.hideKeyboard()
        }
    }// body
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
