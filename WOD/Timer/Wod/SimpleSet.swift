//
//  SimpleSet.swift
//  Timer
//
//  Created by lkh on 11/6/23.
//

import SwiftUI

struct SimpleSet: View {
    @State private var cycleBtn: Bool = false
    @State private var setBtn: Bool = false
    @State private var restBtn: Bool = false
    @State private var preparationBtn: Bool = false

    var body: some View {
        Section(header: Text("Right Now").font(.headline)) {
            Button("Round") {
                cycleBtn.toggle()
            }
            .buttonStyle(EffectButtonStyle())
            
            Button("Preparation") {
                preparationBtn.toggle()
            }
            .buttonStyle(EffectButtonStyle())

            Button("Movements") {
                setBtn.toggle()
            }
            .buttonStyle(EffectButtonStyle())


            Button("Rest") {
                restBtn.toggle()
            }
            .buttonStyle(EffectButtonStyle())
        }
    }
}

#Preview {
    SimpleSet()
}
