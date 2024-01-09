//
//  LoopScroll.swift
//  Timer
//
//  Created by lkh on 1/8/24.
//

import SwiftUI

// MARK: - LoopScroll
struct LoopScroll: View {
    // MARK: Binding
    @Binding var loopList: [DetailItem]
    @Binding var selectedLoopIndex: Int
    @Binding var showPopup: Bool
    @Binding var selectType: SelectedSetting? // 0 Scroll, 1 List
    
    // MARK: 프로퍼티
    let mode: Int
    
    // MARK: - View
    var body: some View {
        ScrollView {
            ForEach(loopList.indices, id: \.self) { i in
                LoopScrollRow(
                    row: $loopList[i],
                    isPopup: $showPopup,
                    selectType: $selectType,
                    selectedLoopIndex: $selectedLoopIndex,
                    foreachIdx: i,
                    mode: mode
                )
                Divider()
            } // ForEach
            .padding()
        } // ScrollView
    }
}

