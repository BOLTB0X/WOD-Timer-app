//
//  DetailTopRow.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - DetailTopRow
struct DetailTopRow: View {
    // MARK: Binding
    @Binding var tableType: Int
    @Binding var betweenRest: Bool
    
    // MARK: 프로퍼티
    let action1: () -> Void
    let action2: () -> Void

    // MARK: - View
    var body: some View {
        HStack(alignment: .center,spacing: 10) {
            BasicButton(action: {
                action1()
            }, systemName: tableType == 0 ? "plus.circle" : "trash")
            .foregroundColor(.blue)

            Spacer()
            
            Text(tableType == 0 ? "Rest in between" : "Rests are not visible")
                .contentShape(Rectangle())

            buttonView()
//            CheckButton(click: $betweenRest, systemName: "checkmark.square")
//            
//            Spacer()
//            
//            if tableType == 0 {
//                BasicButton(action: {
//                    tableType = 1
//                },systemName: "gearshape")
//                .foregroundColor(.blue)
//            } else {
//                BasicButton(action: {
//                    tableType = 0
//                },systemName: "checkmark.circle")
//                .foregroundColor(.blue)
//            }
        } // HStack
        
        .onChange(of: tableType) { _ in
            action2()
        }
        
        .padding(.horizontal)
        .padding()
    }
    
    // MARK: - ViewBuilder
    // ..
    // MARK: - buttonView
    @ViewBuilder
    private func buttonView() -> some View {
        if tableType == 0 {
            CheckButton(click: $betweenRest, systemName: "checkmark.square")
            
            Spacer()
            
            BasicButton(action: {
                tableType = 1
            },systemName: "gearshape")
            .foregroundColor(.blue)
        } else {
            Spacer()
            
            BasicButton(action: {
                tableType = 0
            },systemName: "checkmark.circle")
            .foregroundColor(.blue)
        }
    }
}
