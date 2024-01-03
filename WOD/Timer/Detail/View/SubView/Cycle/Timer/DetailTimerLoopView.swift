//
//  DetailTimerCycleSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailTimerCycleSet
struct DetailTimerLoopView: View {
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
                DetailCycleTop(
                    tableType: $tableType,
                    betweenRest: $viewModel.betweenRest,
                    createRemoveAction: {
                        viewModel.createRemoveButtonAction(tableType: $tableType, alret: $showAlert)
                    },
                    sortAction: viewModel.sortTimerCycleList
                ) // DetailTopRow
                
                Divider()
                
                displayCycle()
            
            } // VStack
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
                    title: "Movement loop"
                ) // navigationBasicToolbar
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
                ForEach(viewModel.timerLoopList.indices, id: \.self) { i in
                    if viewModel.timerLoopList[i].type == .movement {
                        TimerLoopListRow(
                            isSelected: $viewModel.multiSelection,
                            row: viewModel.timerLoopList[i]
                        )
                    }
                } // ForEach
                .onMove(perform: viewModel.moveCycleItem)
            } // List
            .listStyle(PlainListStyle())
            .environment(\.editMode, .constant(.active))
            
            Divider()
            
            DetailDefaultState(
                defaultMove: $viewModel.defaultMove,
                defaultRest: $viewModel.defaultRest,
                isPopup: $showPopup,
                selectType: $selectType)
        } else {
            ScrollView {
                ForEach(viewModel.timerLoopList.indices, id: \.self) { i in
                    TimerLoopScrollRow(
                        row: $viewModel.timerLoopList[i],
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
        if let type = selectType {
            switch type {
            case .color, .defaultMoveColor, .defaultRestColor:
                DetailTimeColorSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
            case .text, .defaultMoveText, .defaultRestText:
                DetailTimerTextSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
                
            case .defaultMoveTime, .defaultRestTime:
                DetailTimerMovementSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
                
            default:
                DetailTimerMovementSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
            } // switch
        }
    } // displayPopup
}

struct DetailTimerCycleSet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerLoopView(rootView: .constant(false))
            .environmentObject(DetailViewModel.shared)
    }
}
