//
//  DetailCycleEditState.swift
//  Timer
//
//  Created by lkh on 12/31/23.
//

import SwiftUI

struct DetailCycleEditState: View {
    // MARK: Binding
    @Binding var defaultMove: DetailItem
    @Binding var defaultRest: DetailItem

    @Binding var isPopup: Bool
    
    var body: some View{
        VStack(alignment: .center, spacing: 0) {
            Text("Default Edit")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 25) {

                    DetailCycleEditStateRow(row: $defaultMove, isPopup: $isPopup)

                    DetailCycleEditStateRow(row: $defaultRest, isPopup: $isPopup)
                    
                } // VStack
                .layoutPriority(100)
                
                Spacer()
            } // HStack
            .padding()
            
        } // VStack
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
        ) // overlay
        .padding(.horizontal)
    } // body
}

struct DetailCycleEditStateRow: View {
    // MARK: Binding
    @Binding var row: DetailItem
    @Binding var isPopup: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Button(action: {

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

            }, label: {
                Text(row.title)
                    .font(.title)
            })  // Button
            .buttonStyle(EffectButtonStyle())
            
            Spacer()

            Button(action: {

            }, label: {
                Text(row.time.totalSeconds.asTimestamp)
            }) // Button
            .buttonStyle(EffectButtonStyle())
        }
    }
}

struct DetailCycleEditState_Previews: PreviewProvider {
    static var previews: some View {
        DetailCycleEditState(
            defaultMove: .constant(DetailItem(type: .movement, title: "test")),
            defaultRest: .constant(DetailItem(type: .rest, title: "test")),
            isPopup: .constant(false))
    }
}
