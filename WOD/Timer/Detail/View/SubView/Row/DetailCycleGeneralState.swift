//
//  DetailCycleState.swift
//  Timer
//
//  Created by lkh on 12/31/23.
//

import SwiftUI

struct DetailCycleGeneralState: View {
    let title: String
    let text1: String
    let subText1: String
    let text2: String
    let subText2: String
    
    var body: some View{
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(text1)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    Text(subText1)
                        .foregroundColor(.secondary)
                        
                } // VStack
                .layoutPriority(100)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(text2)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)

                    Text(subText2)
                        .foregroundColor(.secondary)
                }
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

struct DetailCycleGeneralState_Previews: PreviewProvider {
    static var previews: some View {
        DetailCycleGeneralState(title: "Current Cycle State", text1: "Movements", subText1: "3 / 00:30", text2: "Rests", subText2: "2 / 00:12")
    }
}
