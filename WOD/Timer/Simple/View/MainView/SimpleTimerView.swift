//
//  SimpleTimerView.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import SwiftUI

// MARK: - SimpleTimerView
struct SimpleTimerView: View {
    @EnvironmentObject private var viewModel: SimpleViewModel
    @Binding var isBackRootView: Bool
    var avManger = AVManager.shared
    
    var body: some View {
        NavigationView {
            // MARK: - View Main
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                // MARK: SimpleTimerDisplayTime
                SimpleTimerDisplayTime()
                    .environmentObject(viewModel)
                Spacer()
                
                Divider()

                // MARK: SimpleTimerControl
                SimpleTimerControl()
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
                        viewModel.simpleTimerCanclled()
                        isBackRootView.toggle()
                    }, condition: viewModel.isDisplayToolbarTmBtn, systemName: "arrow.backward")
                }
                
                // MARK: 오른쪽 새로고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButton(action: viewModel.simpleTimerRestart, condition: viewModel.isDisplayToolbarTmBtn, systemName: "arrow.clockwise")
                }
            } // toolbar
        } // NavigationView
        .onAppear {
            viewModel.nextSimpleTimerRound()
        }
    } // body
    
}

struct SimpleTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTimerView(isBackRootView: .constant(true))
            .environmentObject(SimpleViewModel())
    }
}
