//
//  TimerCycleScrollRow.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - TimerCycleScrollRow
struct TimerLoopScrollRow: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: Binding
    @Binding var row: DetailItem
    @Binding var isPopup: Bool
    @Binding var selectType: SelectedSetting?
    
    // MARK: 프로퍼티
    let idx: Int
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                viewModel.selectedTimerLoopIndex = idx
                selectType = .color
                isPopup.toggle()
            }, label: {
                ZStack {
                    Circle()
                        .fill(Color(row.color.IndexToColor))
                        .frame(width: 40, height: 50)
                    
                    Circle()
                        .stroke(Color.secondary)
                        .frame(width: 40, height: 50)
                }
            })  // Button
            .buttonStyle(EffectButtonStyle())
            
            Spacer()
                .frame(width: 15)
            
            Button(action: {
                viewModel.selectedTimerLoopIndex = idx
                selectType = .text
                isPopup.toggle()
            }, label: {
                Text(row.title)
                    .font(.title)
            })  // Button
            .buttonStyle(EffectButtonStyle())
            
            Spacer()

            Button(action: {
                viewModel.selectedTimerLoopIndex = idx
                selectType = .time
                isPopup.toggle()
            }, label: {
                Text(row.time.totalSeconds.asTimestamp)
            }) // Button
            .buttonStyle(EffectButtonStyle())
        } // HStack
        .padding(.horizontal)
    } // body
}
