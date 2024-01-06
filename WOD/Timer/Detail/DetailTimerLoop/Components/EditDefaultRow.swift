//
//  DetailDefaultRow.swift
//  Timer
//
//  Created by lkh on 1/1/24.
//

import SwiftUI

// MARK: - EditDefaultRow
struct EditDefaultRow: View {
    // MARK: Binding
    @Binding var row: DetailItem
    @Binding var isPopup: Bool
    @Binding var selectType: SelectedSetting?

    // MARK: 프로퍼티
    let type: Int // 0 운동 1 휴식
    
    // MARK: - View
    var body: some View {
        // MARK: main
        HStack(alignment: .center, spacing: 5) {
            Button(action: {
                if type == 0 {
                    selectType = .defaultMoveColor
                } else {
                    selectType = .defaultRestColor
                }
                isPopup.toggle()
            }, label: {
                ZStack {
                    Circle()
                        .fill(Color(row.color.IndexToColor))
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .stroke(Color.secondary)
                        .frame(width: 30, height: 30)
                }
            })  // Button
            .buttonStyle(EffectButtonStyle())
            
            Spacer()
                .frame(width: 15)
            
            Button(action: {
                if type == 0 {
                    selectType = .defaultMoveText
                } else {
                    selectType = .defaultRestText
                }
                isPopup.toggle()
            }, label: {
                Text(row.title)
                    .font(.title)
            })  // Button
            .buttonStyle(EffectButtonStyle())
            
            Spacer()

            Button(action: {
                if type == 0 {
                    selectType = .defaultMoveTime
                } else {
                    selectType = .defaultRestTime
                }
                isPopup.toggle()
            }, label: {
                Text(row.time.totalSeconds.asTimestamp)
            }) // Button
            .buttonStyle(EffectButtonStyle())
        } // HStack
    } // body
}
