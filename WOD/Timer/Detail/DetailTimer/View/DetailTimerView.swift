//
//  DetailTimerView.swift
//  Timer
//
//  Created by lkh on 1/2/24.
//

import SwiftUI

// MARK: - DetailTimerView
struct DetailTimerView: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: Binding
    @Binding var isBackRootView: Bool
    
    // MARK: 프로퍼티
    var avManger = AVManager.shared
    
    // MARK: - View
    var body: some View {
        NavigationView {
            // MARK: main
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                // MARK: DetailTimerDisplayTime
                DetailTimerDisplayTime()
                    .environmentObject(viewModel)
                
                Spacer()
                
                Divider()
                
                // MARK: DetailTimerControl
                DetailTimerControl()
                    .environmentObject(viewModel)
                
            } // VStack
            
            // MARK: - side
            .navigationTitle("\(viewModel.detailRTotalTime.asTimestamp)")
                    .bold()
                    .foregroundColor(.black)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                // MARK: 왼쪽 뒤로가기
                ToolbarItem(placement: .navigationBarLeading) {
                    ToolbarButton(action: {
                        viewModel.detailTimerCanclled()
                        isBackRootView.toggle()},
                        condition:  viewModel.isDisplayToolbarTmBtn,
                        systemName: "arrow.backward")
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButton(action: viewModel.detailTimerRestart, condition: viewModel.isDisplayToolbarTmBtn, systemName: "arrow.clockwise")
                }
            } // toolbar
        } // NavigationView
        .onAppear {
            viewModel.nextDetailTimerRound()
        }
    } // body
}

struct DetailTimerView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerView(isBackRootView: .constant(true))
            .environmentObject(DetailViewModel())
    }
}
