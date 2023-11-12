//
//  RestSet.swift
//  Timer
//
//  Created by lkh on 11/11/23.
//

import SwiftUI

struct RestSet: View {
    @EnvironmentObject var viewModel: WodViewModel
    @Binding var isChange: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                        if isChange  {
                            SettingTextField(setBinding: $viewModel.selectedRestAmount)
                        }
                        else {
                            SettingPicker(title: "Rest",
                                          range: viewModel.secondsRange,
                                              binding: $viewModel.selectedRestAmount)
                            .onTapGesture {
                                isChange.toggle()
                            }
                        }
                }
            }
        }
    }
}

