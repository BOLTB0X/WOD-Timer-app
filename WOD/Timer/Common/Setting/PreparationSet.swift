//
//  PreparationSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct PreparationSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @State private var isChange: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    Group {
                        if isChange  {
                            SettingTextField(setBinding: $viewModel.selectedPreparationAmount)
                        }
                        else {
                            SettingPicker(title: "Preparation",
                                              range: viewModel.preparationRange,
                                              binding: $viewModel.selectedPreparationAmount)
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

