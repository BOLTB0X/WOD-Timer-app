//
//  TimerCycleListRow.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - TimerCycleLisButtontRow
struct TimerCycleListRow: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: Binding
    @Binding var row: DetailItem
    
    // MARK: 프로퍼티
    let idx: Int
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                viewModel.selectedTimerCycleItem = viewModel.timerCycleList[idx]
                viewModel.selectedTimerCycleIndex = idx
            }, label: {
                HStack(alignment: .center, spacing: 0) {
                    Circle()
                        .fill(Color(row.color.IndexToColor))
                        .frame(width: 40, height: 50)
                    
                    Spacer()
                        .frame(width: 15)
                    
                    Text(row.title)
                        .font(.title)
                    
                    Spacer()
                        .frame(width: 25)
                    
                    Text(row.time.totalSeconds.asTimestamp)
                    
                } // HStack
                .contentShape(Rectangle())
            }) // Button
            .buttonStyle(EffectButtonStyle())
        } // HStack
    } // body
}


