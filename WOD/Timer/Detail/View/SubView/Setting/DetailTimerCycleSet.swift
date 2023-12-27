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
    //@Environment(\.editMode) var editMode
    
    // MARK: State
    // 뷰 관련
    @State private var showPopup: Bool = false
    
    // 컴포넌트 관련
    @State private var tableType: Int = 0 // 0 Scroll, 1 List
    @State private var selectType: SelectedSetting?
    
    // edit 관련
    @State private var betweenRest: Bool = false
    
    // MARK: Binding
    @Binding var rootView: Bool
    
    // MARK: - View
    var body: some View {
        NavigationView {
            VStack(alignment: .center,spacing: 0) {
                DetailButtonTopRow(
                    tableType: $tableType,
                    betweenRest: $viewModel.betweenRest,
                    createAction: viewModel.createCycleItem)
//                HStack(alignment: .center,spacing: 10) {
//                    BasicButton(action: {
//                        viewModel.createCycleItem()
//                    }, systemName: "plus.circle")
//                    .foregroundColor(.blue)
//
//                    Spacer()
//
//                    Text("Rest in between")
//                        .font(.subheadline)
//                    
//                    CheckButton(click: $betweenRest, systemName: "checkmark.square")
//                    
//                    Spacer()
//                    
//                    if tableType == 0 {
//                        BasicButton(action: {
//                            tableType = 1
////                            editMode?.wrappedValue = .active
//                            //isActionSheet.toggle()
//                        },systemName: "gearshape")
//                        .foregroundColor(.blue)
//                    } else {
//                        BasicButton(action: {
//                            tableType = 0
////                            editMode?.wrappedValue = .inactive
//                        },systemName: "checkmark.circle")
//                        .foregroundColor(.blue)
//                    }
//                } // HStack
//                .padding(.horizontal)
//                .padding()
                
                Divider()
                
                displayCycle()
                
                // MARK: - popupNavigationView
                // 팝업
                    .popupNavigationView(show: $showPopup) {
                        displayPopup()
                    }
                
                // MARK: - navigationBasicToolbar
                    .navigationBasicToolbar(
                        backAction: { rootView.toggle() },
                        title: "Cycle Set"
                    ) // navigationBasicToolbar
            } // VStack
        } // NavigationView
    } // body
    
    // MARK: - ViewBuilder
    // ...
    // MARK: - cycleList
    @ViewBuilder
    private func cycleList() -> some View {
        // MARK: main
        List {
            ForEach(viewModel.timerCycleList.indices, id: \.self) { i in
                TimerCycleListRow(
                    row: $viewModel.timerCycleList[i],
                    idx: i)
                .environmentObject(viewModel)
            } // ForEach
            .onDelete(perform: viewModel.removeCycleItem)
            .onMove(perform: viewModel.moveCycleItem)
            .padding(.horizontal)
        } // List
        
        // MARK: side
        .onAppear {
            UITableView.appearance().isEditing = true
        }
        
        .onDisappear {
            UITableView.appearance().isEditing = false
        }
        
        .listStyle(PlainListStyle())
        //.environment(\.editMode, editMode)
    }
    
    // MARK: - cycleScroll
    @ViewBuilder
    private func cycleScroll() -> some View {
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
    }
    
    // MARK: - displayCycle
    @ViewBuilder
    private func displayCycle() -> some View {
        if tableType == 1 {
            cycleList()
        } else {
            cycleScroll()
        }
    }
    
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
        }
    }
}

//struct DetailTimerCycleSet_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailTimerCycleSet(rootView: .constant(false))
//            .environmentObject(DetailViewModel.shared)
//    }
//}
