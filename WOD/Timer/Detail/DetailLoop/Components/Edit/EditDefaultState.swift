//
//  DetailCycleEditState.swift
//  Timer
//
//  Created by lkh on 12/31/23.
//

import SwiftUI

// MARK: - DetailEditState
struct EditDefaultState: View {
    // MARK: Binding
    @Binding var defaultMove: DetailItem
    @Binding var defaultRest: DetailItem
    @Binding var isPopup: Bool
    @Binding var selectType: SelectedSetting?
    
    // MARK: - View
    var body: some View{
        // MARK: main
        VStack(alignment: .center, spacing: 0) {
            Text("Default Edit")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
            
            Divider()
            
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {

                    EditDefaultRow(
                        row: $defaultMove,
                        isPopup: $isPopup,
                        selectType: $selectType,
                        type: 0
                    )
                    
                    Spacer()
                        .frame(height: 30)

                    EditDefaultRow(
                        row: $defaultRest,
                        isPopup: $isPopup,
                        selectType: $selectType,
                        type: 1
                    )
                    
                } // VStack
                .layoutPriority(100)
                
                Spacer()
            } // HStack
            .padding()
            
        } // VStack
        .padding(.horizontal)
    } // body
}

struct EditDefaultState_Previews: PreviewProvider {
    static var previews: some View {
        EditDefaultState(
            defaultMove: .constant(DetailItem(type: .movement, title: "test")),
            defaultRest: .constant(DetailItem(type: .rest, title: "test")),
            isPopup: .constant(false),
            selectType: .constant(nil))
    }
}
