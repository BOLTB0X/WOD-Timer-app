//
//  CardView.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - CardCellRow
struct CardCellRow: View {
    // MARK: 프로퍼티
    let title: String
    let text1: String
    let subText1: String
    let text2: String
    let subText2: String
    
    // MARK: - View
    var body: some View{
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(text1)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    Text(subText1)
                        .foregroundColor(.secondary)
                } // VStack
                .layoutPriority(100)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(text2)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    
                    Text(subText2)
                        .foregroundColor(.secondary)
                } // VStack
                .layoutPriority(100)
                
            } // HStack
            .padding()
            
        } // VStack
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
        ) // overlay
    } // body
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardCellRow(title: "1 Round", text1: "movements", subText1: "00:30", text2: "Rest", subText2: "00:12")
    }
}
