//
//  LoopListTimer.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI

// MARK: - LoopList
struct LoopList: View {
    // MARK: Binding
    @Binding var loopList: [DetailItem]
    @Binding var multiSelection: Set<UUID>
    
    // MARK: 프로퍼티
    let moveItemFunction: (IndexSet, Int) -> Void
    let mode: Int
    
    // MARK: - View
    var body: some View {
        List {
            ForEach(loopList.indices, id: \.self) { i in
                if loopList[i].type == .movement {
                    LoopListRow(
                        isSelected: $multiSelection,
                        row: loopList[i],
                        mode: mode
                    )
                }
            } // ForEach
            .onMove(perform: moveItemFunction)
        } // List
        .listStyle(PlainListStyle())
        .environment(\.editMode, .constant(.active))
    } // body
}

