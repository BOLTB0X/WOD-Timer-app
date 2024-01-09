//
//  DetailTimerCycleSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - DetailLoopView
struct DetailLoopView: View {
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
    @Binding var modeBtn: Int
    
    // MARK: - View
    var body: some View {
        // MARK: main
        NavigationView {
            VStack(alignment: .center,spacing: 0) {
                DetailLoopTop(
                    tableType: $tableType,
                    betweenRest: modeBtn == 0 ? $viewModel.betweenRestInTimer : $viewModel.betweenRestInStop,
                    createRemoveAction: {
                        viewModel.createRemoveButtonAction(tableType: $tableType, alret: $showAlert, mode: modeBtn)
                    },
                    sortAction: modeBtn == 0 ? viewModel.sortTimerLoopList : viewModel.sortStopLoopList
                ) // DetailLoopTop
                
                Divider()
                
                if modeBtn == 0 {
                    displayTimerLoop()
                } else {
                    displayStopLoop()
                }
                
            } // VStack
            // MARK: side
            // MARK: - popupNavigationView
            // 팝업
            .popupNavigationView(show: $showPopup) {
                if modeBtn == 0 {
                    displayTimerPopup()
                } else {
                    displayStopwatchPopup()
                }
            } // popupNavigationView
            
            // MARK: - navigationBasicToolbar
            .navigationBasicToolbar(
                backAction: {
                    rootView.toggle()
                },
                title: modeBtn == 0 ? "Timer Movement Loop" :  "Stopwatch Movement Loop"
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
    // MARK: - displayLoop
    @ViewBuilder
    private func displayTimerLoop() -> some View {
        if tableType == 1 { // 편집
            LoopList(
                loopList: $viewModel.timerLoopList,
                multiSelection: $viewModel.multiSelection,
                moveItemFunction: viewModel.moveTimerLoopItem,
                mode: modeBtn
            )
            
            Divider()
            
            EditDefaultState(
                defaultMove: $viewModel.defaultMove,
                defaultRest: $viewModel.defaultRest,
                isPopup: $showPopup,
                selectType: $selectType
            )
        } else { // 일반
            LoopScroll(
                loopList: $viewModel.timerLoopList,
                selectedLoopIndex: $viewModel.selectedTimerLoopIndex,
                showPopup: $showPopup,
                selectType: $selectType,
                mode: modeBtn
            )
        } // if - else
    } // displayTimerLoop
    
    // MARK: - displayLoop
    @ViewBuilder
    private func displayStopLoop() -> some View {
        if tableType == 1 { // 편집
            LoopList(
                loopList: $viewModel.stopLoopList,
                multiSelection: $viewModel.multiSelection,
                moveItemFunction: viewModel.moveStopLoopItem,
                mode: modeBtn
            )
            
            Divider()
            
            EditDefaultState(
                defaultMove: $viewModel.defaultMove,
                defaultRest: $viewModel.defaultRest,
                isPopup: $showPopup,
                selectType: $selectType
            )
        } else { // 일반
            LoopScroll(
                loopList: $viewModel.stopLoopList,
                selectedLoopIndex: $viewModel.selectedStopLoopIndex,
                showPopup: $showPopup,
                selectType: $selectType,
                mode: modeBtn
            )
        } // if - else
    } // displayTimerLoop
    
    // MARK: - displayTimerPopup
    @ViewBuilder
    private func displayTimerPopup() -> some View {
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
    } // displayTimerPopup
    
    // MARK: - displayStopwatchPopup
    @ViewBuilder
    private func displayStopwatchPopup() -> some View {
        if let type = selectType {
            switch type {
            case .color, .defaultMoveColor, .defaultRestColor:
                DetailStopwatchColorSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
            case .text, .defaultMoveText, .defaultRestText:
                DetailStopwatchTextSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)

            default:
                DetailTimerMovementSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
            } // switch
        }
    } // displayTimerPopup
}

struct DetailLoopView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLoopView(rootView: .constant(false), modeBtn: .constant(1))
            .environmentObject(DetailViewModel.shared)
    }
}
