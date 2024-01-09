//
//  DetailStopwatchView.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI

// MARK: - DetailStopwatchView
struct DetailStopwatchView: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: Binding
    @Binding var isBackRootView: Bool
    
    // MARK: 프로퍼티
    var avManger = AVManager.shared
    
    // MARK: - View
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                // 시간
                DetailStopwatchDisplayTime()
                    .environmentObject(viewModel)
                
                Spacer()
                
                Divider()
                
                // MARK: SimpleStopwatchControl
                DetailStopwatchControl()
                    .environmentObject(viewModel)
            } // VStack
            
            // MARK: - side
            .navigationTitle(
                Text("\(viewModel.detailSTotalTime.asTimestamp)")
                    .bold()
                    .foregroundColor(.black))
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                // MARK: 왼쪽 뒤로가기
                ToolbarItem(placement: .navigationBarLeading) {
                    ToolbarButton(action: {
                        viewModel.detailStopCanclled()
                        isBackRootView.toggle()},
                        condition:  viewModel.isDisplayToolbarSwBtn,
                        systemName: "arrow.backward")
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButton(action: viewModel.detailStopRestart, condition: viewModel.isDisplayToolbarSwBtn, systemName: "arrow.clockwise")
                }
            } // toolbar
        } // NavigationView
        .onAppear {
            viewModel.nextDetailStopRound()
        }
    } // body
}

struct DetailStopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStopwatchView(isBackRootView: .constant(true))
            .environmentObject(DetailViewModel())
    }
}

