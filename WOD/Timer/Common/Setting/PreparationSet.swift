//
//  PreparationSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct PreparationSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @Binding var isChange: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
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
            }
        }
    }
}

