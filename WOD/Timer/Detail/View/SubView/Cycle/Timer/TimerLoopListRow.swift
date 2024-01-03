//
//  TimerCycleListRow.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - TimerCycleLisButtontRow
struct TimerLoopListRow: View {
    // MARK: State
    @State private var isTouch: Bool = false
    
    // MARK: Binding
    @Binding var isSelected: Set<UUID>
    
    // MARK: 프로퍼티
    let row: DetailItem
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            RadioButton(isTouch: $isTouch)
            
            Spacer()
                .frame(width: 25)
            
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
        
        .onTapGesture {
            isTouch.toggle()
            if isTouch {
                isSelected.insert(row.id)
            } else {
                isSelected.remove(row.id)
            }
        }
        
        .onChange(of: isSelected) { _ in
            isTouch = isSelected.contains(row.id)
        }
        
    } // body
}

