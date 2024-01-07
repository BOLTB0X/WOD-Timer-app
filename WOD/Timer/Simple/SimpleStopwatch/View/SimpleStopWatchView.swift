//
//  SimpleStopWatchView.swift
//  Timer
//
//  Created by lkh on 12/20/23.
//

import SwiftUI

// MARK: - SimpleStopWatchView
struct SimpleStopWatchView: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    @Binding var isBackRootView: Bool
    
    var avManger = AVManager.shared
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                // MARK: displayTime
                SimpleStopwatchDisplayTime()
                    .environmentObject(viewModel)
                
                Spacer()
                
                Divider()
                
                // MARK: SimpleStopwatchControl
                SimpleStopwatchControl()
                    .environmentObject(viewModel)
                
            } // VStack
            
            // MARK: - side
            .navigationTitle(
                Text("\(viewModel.simpleTotalTime.asTimestamp)")
                    .bold()
                    .foregroundColor(.black))
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                // MARK: 왼쪽 뒤로가기
                ToolbarItem(placement: .navigationBarLeading) {
                    ToolbarButton(action: {
                        isBackRootView.toggle()
                    }, condition: viewModel.isDisplayToolbarSwBtn, systemName: "arrow.backward")
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButton(action: viewModel.simpleStopRestart, condition: viewModel.isDisplayToolbarSwBtn, systemName: "arrow.clockwise")
                }
            } // toolbar
        } // NavigationView
        .onAppear {
            viewModel.nextSimpleStopwatchRound()
        }
    } // body

}

struct SimpleStopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleStopWatchView(isBackRootView: .constant(true))
            .environmentObject(SimpleViewModel())
    }
}

