//
//  DetailTimerCycleSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailTimerCycleSet
struct DetailTimerCycleSet: View {
    // MARK: Environment
    @EnvironmentObject private var viewModel: DetailViewModel
    
    // MARK: State
    // 뷰 관련
    @State private var showPopup: Bool = false
    @State private var showAlert = false
    // 컴포넌트 관련
    @State private var tableType: Int = 0 // 0 Scroll, 1 List
    @State private var selectType: SelectedSetting?
    
    // MARK: Binding
    @Binding var rootView: Bool
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            VStack(alignment: .center,spacing: 0) {
                DetailTopRow(
                    tableType: $tableType,
                    betweenRest: $viewModel.betweenRest,
                    createMoveAction: {
                        viewModel.createType = .movement
                        viewModel.createRemoveButtonAction(tableType: $tableType, alret: $showAlert)
                    },
                    createRestAction: {
                        viewModel.createType = .rest
                        viewModel.createRemoveButtonAction(tableType: $tableType, alret: $showAlert)
                    },
                    removeAction: {
                        viewModel.createRemoveButtonAction(tableType: $tableType, alret: $showAlert)
                    },
                    sortAction: {
                        viewModel.sortTimerCycleList()
                    }
                ) // DetailTopRow
                
                Divider()
                
                displayCycle()
                
                // MARK: side
                // MARK: - popupNavigationView
                // 팝업
                    .popupNavigationView(show: $showPopup) {
                        displayPopup()
                    } // popupNavigationView
                
                // MARK: - navigationBasicToolbar
                    .navigationBasicToolbar(
                        backAction: {
                            rootView.toggle()
                        },
                        title: "Cycle Set"
                    ) // navigationBasicToolbar
            } // VStack
        } // NavigationView
        // MARK: - alert
        // 경고창
            .alert(isPresented: $showAlert) {
                return Alert(title: Text(viewModel.alretMessage))
            }
    } // body
    
    // MARK: - ViewBuilder
    // ...
    // MARK: - displayCycle
    @ViewBuilder
    private func displayCycle() -> some View {
        if tableType == 1 {
            // MARK: main
            List {
                ForEach(viewModel.timerCycleList.indices, id: \.self) { i in
                    if viewModel.timerCycleList[i].type == .movement {
                        TimerCycleListRow(
                            isSelected: $viewModel.multiSelection,
                            row: viewModel.timerCycleList[i]
                        )
                    }
                } // ForEach
                .onMove(perform: viewModel.moveCycleItem)
            } // List
            .listStyle(PlainListStyle())
            .environment(\.editMode, .constant(.active))
        } else {
            ScrollView {
                ForEach(viewModel.timerCycleList.indices, id: \.self) { i in
                    TimerCycleScrollRow(
                        row: $viewModel.timerCycleList[i],
                        isPopup: $showPopup,
                        selectType: $selectType,
                        idx: i)
                    .environmentObject(viewModel)
                    Divider()
                } // ForEach
                .padding()
            } // ScrollView
        } // if - else
    } // displayCycle
    
    // MARK: - displayPopup
    @ViewBuilder
    private func displayPopup() -> some View {
        switch selectType {
        case .color:
            DetailTimerSetItemColor(showPopup: $showPopup)
                .environmentObject(viewModel)
        case .text:
            DetailTimerSetItemText(showPopup: $showPopup)
                .environmentObject(viewModel)
        default:
            DetailTimerSetItemMovement(showPopup: $showPopup)
                .environmentObject(viewModel)
        } // switch
    } // displayPopup
}

struct DetailTimerCycleSet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerCycleSet(rootView: .constant(false))
            .environmentObject(DetailViewModel.shared)
    }
}
