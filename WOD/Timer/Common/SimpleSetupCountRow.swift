//
//  SimpleSetupRow.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumIntegerDigits = 2
    return formatter
}()

struct SimpleSetupCountRow: View {
    let title: String
    @Binding var inputStr: Int
    let btnImg1: String
    let btnImg2: String
    
    var btn1Action: (() -> Void)?
    var btn2Action: (() -> Void)?

        
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text(title)
                
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                Button(action: {btn1Action },
                       label: {
                    Image(systemName: btnImg1)        .resizable()
                        .frame(width: 40, height: 40)
                })

                TextField("set", value: $inputStr, formatter: formatter)
                    //.focused($isFocused)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .frame(width: 80, height: 40)
                    .font(.system(size: 40))
                
                Button(action: {btn2Action },
                       label: {
                    Image(systemName: btnImg2)
                        .resizable()
                        .frame(width: 40, height: 40)
                })
                Spacer()
            }
        }
        .onTapGesture { // 키보드 내리기용
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct SimpleSetupCountRow_Previews: PreviewProvider {
    @State static var inputString = 3
    
    static var previews: some View {
        SimpleSetupCountRow(
            title: "Round",
            inputStr: $inputString,
            btnImg1: "minus.circle",
            btnImg2: "plus.circle"
        )
        .previewLayout(.sizeThatFits)
    }
}
