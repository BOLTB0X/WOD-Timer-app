//
//  DetailTimerCycleSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailTimerCycleSet
struct DetailTimerCycleSet: View {
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: State
    @State private var showPopup: Bool = false
    @State private var isActionSheet: Bool = false
    @State private var selectType: SelectedSetting?
    
    // MARK: Binding
    @Binding var rootView: Bool
    
    // MARK: Main
    var body: some View {
        NavigationView {
            VStack(alignment: .center,spacing: 0) {
                HStack(alignment: .center,spacing: 0) {
                    Spacer()
                }
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.timerCycleList.indices, id: \.self) { i in
                        DetailTimerCycleButtonSetRow(
                            row: $viewModel.timerCycleList[i],
                            isPopup: $showPopup,
                            idx: i)
                        .environmentObject(viewModel)
                    } // ForEach
                    .padding(.horizontal)
                } // List
                .listStyle(PlainListStyle())
                .navigationBarBackButtonHidden()
                
                // MARK: - popupNavigationView
                // 팝업
                .popupNavigationView(show: $showPopup) {
                    DetailTimerCycleItemSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
                }
                
                // MARK: - navigationBasicToolbar
                .navigationBasicToolbar(
                    backAction: { rootView.toggle() },
                    title: "Cycle Set"
                ) // navigationBasicToolbar
            } // VStack
        } // NavigationView
    } // body
}

// MARK: - DetailTimerCycleButtonSetRow
struct DetailTimerCycleButtonSetRow: View {
    // MARK: Object
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: Binding
    @Binding var row: DetailItem
    @Binding var isPopup: Bool
    
    // MARK: 프로퍼티
    let idx: Int
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                viewModel.selectedCycleItem = viewModel.timerCycleList[idx]
                isPopup.toggle()
            }, label: {
                HStack(alignment: .center, spacing: 0) {
                    Circle()
                        .fill(Color(row.color))
                        .frame(width: 40, height: 50)
                    
                    Spacer()
                        .frame(width: 15)
                    
                    Text(row.title)
                        .font(.title)
                    
                    Spacer()
                    
                    Text(row.time.asTimestamp)
                    
                } // HStack
                //.contentShape(Rectangle())
            }) // Button
            .buttonStyle(EffectButtonStyle())
        } // HStack
    } // body
}


struct DetailTimerCycleSet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerCycleSet(rootView: .constant(false))
            .environmentObject(DetailViewModel.shared)
    }
}
