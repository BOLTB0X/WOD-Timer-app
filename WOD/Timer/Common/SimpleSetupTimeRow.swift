//
//  SimpleSetupTimeRow.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct SimpleSetupTimeRow: View {
    @Binding var inputMin: String
    @Binding var inputSec: String

    let btnImg1: String
    let btnImg2: String
    var btn1Action: (() -> Void)?
    var btn2Action: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Spacer()
                
                TextField("min", text: $inputMin)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: geometry.size.width * 0.2, height: 40) // Geometry 이용
                .font(.system(size: 40)) // 큰걸 좋아하니
                
                Text(" : ")
                    .font(.system(size: 40))
                
                TextField("min", text: $inputSec)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: geometry.size.width * 0.2, height: 40)
                .font(.system(size: 40))
                
                Button(action: { btn1Action },
                       label: { Image(systemName: btnImg1)})
                
                Button(action: { btn2Action },
                       label: { Image(systemName: btnImg2)})
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    SimpleSetupTimeRow()
//}
