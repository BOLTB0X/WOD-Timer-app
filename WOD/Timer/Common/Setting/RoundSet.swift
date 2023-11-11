//
//  RoundSet.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

struct RoundSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @State private var isChange: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    Group {
                        if isChange  {
                            SettingTextField(setBinding: $viewModel.selectedRoundAmount)
                        }
                        else {
                            SettingPicker(title: "round",
                                              range: viewModel.roundRange,
                                              binding: $viewModel.selectedRoundAmount)
                            .onTapGesture {
                                isChange.toggle()
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(!isChange ? "keyboard" : "Wheel") {
                        isChange.toggle()
                    }
                }
            }
        }
    }
}
