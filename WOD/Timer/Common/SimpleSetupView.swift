//
//  SimpleSetupView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct SimpleSetupView: View {
    @ObservedObject var simpleViewModel = WodInterViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Form {
                Section(header: Text("Simple")) {
                    SimpleSetupCountRow(
                        title: "Round",
                        inputStr: $simpleViewModel.inputSimple.roundInput,
                        btnImg1: "minus.square.fill",
                        btnImg2: "plus.app.fill",
                        btn1Action: simpleViewModel.incrementRound
                    )
                    
                    SimpleSetupTimeRow(
                        inputMin: $simpleViewModel.inputSimple.workMinInput,
                        inputSec: $simpleViewModel.inputSimple.workSecInput,
                        title: "Movements",
                        btnImg1: "minus.square.fill",
                        btnImg2: "plus.app.fill"
                    )
                    
                    SimpleSetupTimeRow(
                        inputMin: $simpleViewModel.inputSimple.restMinInput,
                        inputSec: $simpleViewModel.inputSimple.restSecInput,
                        title: "Rest",
                        btnImg1: "minus.square.fill",
                        btnImg2: "plus.app.fill"
                    )
                }
            }
        }
    }
}


#Preview {
    SimpleSetupView()
}
