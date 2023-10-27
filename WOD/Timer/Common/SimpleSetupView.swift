//
//  SimpleSetupView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct SimpleSetupView: View {
    @State private var userSet: String = "3"
    @State private var userReady1: String = "00"
    @State private var userReady2: String = "30"

    
    var body: some View {
            VStack(alignment: .center) {
                Text("SET")
                SimpleSetupCountRow(inputStr: $userSet, btnImg1: "plus.app.fill", btnImg2: "minus.square.fill")
                
                Text("Ready")
                SimpleSetupTimeRow(inputMin: $userReady1, inputSec: $userReady2, btnImg1: "plus.app.fill", btnImg2: "minus.square.fill")
                
                Text("Movements")
                SimpleSetupTimeRow(inputMin: $userReady1, inputSec: $userReady2, btnImg1: "plus.app.fill", btnImg2: "minus.square.fill")

                
                Text("Rest")
                SimpleSetupTimeRow(inputMin: $userReady1, inputSec: $userReady2, btnImg1: "plus.app.fill", btnImg2: "minus.square.fill")

            }
        }        
}



#Preview {
    SimpleSetupView()
}
