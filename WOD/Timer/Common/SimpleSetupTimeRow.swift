//
//  SimpleSetupTimeRow.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct SimpleSetupTimeRow: View {
    @Binding var inputMin: Int
    @Binding var inputSec: Int
    
    let title: String
    let btnImg1: String
    let btnImg2: String
    var btn1Action: (() -> Void)?
    var btn2Action: (() -> Void)?
    
    @State private var isTouch: Bool = false // 추가
    
    var body: some View {
            VStack(alignment: .center, spacing: 15) {
                Text(title)
                   
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button(action: { btn1Action },
                           label: { Image(systemName: btnImg1)
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                    
                    TextField("min", value: $inputMin, formatter: formatter)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 80, height: 40)
                        .font(.system(size: 40))
                    
                    Text(":")
                        .font(.system(size: 40))
                    
                    TextField("min", value: $inputSec, formatter: formatter)
                        .keyboardType(.numberPad)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 80, height: 40)
                        .font(.system(size: 40)) // 큰걸 좋아하니
                    
                    Button(action: { btn2Action },
                           label: { Image(systemName: btnImg2)
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


struct SimpleSetupTimeRow_Previews: PreviewProvider {
    @State static var inputMin = 3
    @State static var inputSec = 0
    
    static var previews: some View {
        SimpleSetupTimeRow(
            inputMin: $inputMin,
            inputSec: $inputSec,
            title: "Time",
            btnImg1: "minus.circle",
            btnImg2: "plus.circle",
            btn1Action: {
                //
            },
            btn2Action: {
                //
            }
        )
        .previewLayout(.sizeThatFits)
    }
}
