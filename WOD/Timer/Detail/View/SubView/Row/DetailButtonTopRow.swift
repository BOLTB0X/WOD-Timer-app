//
//  DetailButtonTopRow.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

// MARK: - DetailButtonTopRow
struct DetailButtonTopRow: View {
    // MARK: Binding
    @Binding var tableType: Int
    @Binding var betweenRest: Bool
    
    // MARK: 프로퍼티s
    var createAction: () -> Void

    // MARK: View
    var body: some View {
        HStack(alignment: .center,spacing: 10) {
            // 추가
            BasicButton(action: {
                createAction()
                //viewModel.createCycleItem()
            }, systemName: "plus.circle")
            .foregroundColor(.blue)

            Spacer()
            
            // 휴식 끼기?
            Text("Rest in between")
                .font(.subheadline)
            
            CheckButton(click: $betweenRest, systemName: "checkmark.square")
            
            Spacer()
            
            // 편집
            if tableType == 0 {
                BasicButton(action: {
                    tableType = 1
//                            editMode?.wrappedValue = .active
                    //isActionSheet.toggle()
                },systemName: "gearshape")
                .foregroundColor(.blue)
            } else {
                BasicButton(action: {
                    tableType = 0
//                            editMode?.wrappedValue = .inactive
                },systemName: "checkmark.circle")
                .foregroundColor(.blue)
            }
        } // HStack
        .padding(.horizontal)
        .padding()
    }
}
