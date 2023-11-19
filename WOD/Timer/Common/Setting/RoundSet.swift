//
//  RoundSet.swift
//  Timer
//
//  Created by lkh on 11/10/23.
//

import SwiftUI

struct RoundSet: View {
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
                        SettingPicker(title: "round",
                                      range: viewModel.roundRange,
                                      binding: $viewModel.selectedRoundAmount)
                        .onTapGesture {
                            isChange.toggle()
                        }
                    }
                }
            }
        }
    }
}
