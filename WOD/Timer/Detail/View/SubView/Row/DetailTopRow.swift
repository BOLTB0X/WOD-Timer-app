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
    let createMoveAction: () -> Void
    let createRestAction: () -> Void
    let removeAction: () -> Void
    let sortAction: () -> Void

    // MARK: - View
    var body: some View {
        HStack(alignment: .center,spacing: 10) {
            typeForButton()
//            BasicButton(action: {
//                removeAction()
//            }, systemName: tableType == 0 ? "plus.circle" : "trash")
//            .foregroundColor(.blue)

            Spacer()
            
            Text(tableType == 0 ? "Rest in between" : "Rests are not visible")
                .contentShape(Rectangle())

            editButton()
        } // HStack
        
        .onChange(of: tableType) { _ in
            sortAction()
        }
        
        .padding(.horizontal)
        .padding()
    } // body
    
    // MARK: - ViewBuilder
    // ..
    @ViewBuilder
    private func typeForButton() -> some View {
        if tableType == 0 {
            if !betweenRest {
                Menu {
                    Button("Movement") {
                        createMoveAction()
                    }
                    
                    Button("Rest") {
                        createRestAction()
                    }
                } label : {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            } else {
                BasicButton(action: {
                    createMoveAction()
                }, systemName: "plus.circle")
                .foregroundColor(.blue)
            }
        } else {
            BasicButton(action: {
                removeAction()
            }, systemName: "trash")
            .foregroundColor(.blue)
        }
    } // typeForButton
    
    // MARK: - buttonView
    @ViewBuilder
    private func editButton() -> some View {
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
    } // buttonView
}
