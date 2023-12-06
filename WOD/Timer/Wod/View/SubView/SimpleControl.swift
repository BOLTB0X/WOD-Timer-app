//
//  SimpleControl.swift
//  Timer
//
//  Created by lkh on 12/4/23.
//

import SwiftUI

struct SimpleControl: View {
    @EnvironmentObject var viewModel: WodViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // before
            ControlButton(action: viewModel.controlBefore, defaultImgName: "chevron.left.2")
            
            // start / pause
            ZStack {
                CircularProgress(progress: $viewModel.simpleUnitProgress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                ControlButton(action:  viewModel.controlPausedOrResumed,
                              img1Name: "play.fill",
                              img2Name: "pause.fill")
            }
            
            // next
            ControlButton(action: viewModel.controlNext, defaultImgName: "chevron.right.2")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

#Preview {
    SimpleControl()
        .environmentObject(WodViewModel.shared)
}
