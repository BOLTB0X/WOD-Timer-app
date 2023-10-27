//
//  SimpleSetupRow.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct SimpleSetupCountRow: View {
    @Binding var inputStr: String
    let btnImg1: String
    let btnImg2: String
    var btn1Action: (() -> Void)?
    var btn2Action: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Spacer()
                TextField("set", text: $inputStr)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: geometry.size.width * 0.2, height: 40) // Geometry 이용
                .font(.system(size: 40)) // 큰걸 좋아하니
                
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
//    SimpleSetupRow()
//}
