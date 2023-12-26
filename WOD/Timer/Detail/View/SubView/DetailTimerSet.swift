//
//  DetailTimerMovementsSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI


// MARK: - DetailTimerMovementsSet
struct DetailTimerCycleItemSet: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State
    @State private var isSelectedColor: Int = 0
    @State private var rootView: Bool = false
    
    // MARK: Binding
    @Binding var showPopup: Bool
    
    // MARK: Main
    var body: some View {
        NavigationView {
            HStack(alignment: .center, spacing: 0) {
                NavigationLink(destination: ColorSegmentedButton(selectedIndex: $isSelectedColor)
                ) {
                    Circle()
                        .fill(Color(viewModel.selectedCycleItem.color))
                        .frame(width: 40, height: 50)
                }
                
                Spacer()
                    .frame(width: 15)
                
                NavigationLink(destination: CustomTextField(text: $manager.movementText, defaultText: "\(viewModel.selectedCycleItem.title)")
                ) {
                    Text(viewModel.selectedCycleItem.title)
                        .font(.title)
                }
                
                Spacer()
                
                NavigationLink(destination:
                    SettingTimeTextField(
                    setHour: $manager.selectedMovementAmount.hours,
                    setMinute: $manager.selectedMovementAmount.minutes,
                    setSecond: $manager.selectedMovementAmount.seconds,
                    isUsedAuto: $manager.isCalculatedBtn,
                    viewModel: manager)
                ) {
                    Text(viewModel.selectedCycleItem.time.asTimestamp)
                        .font(.title)
                }
            }
            .padding(.horizontal)

            
        } // NavigationView
        .onAppear {
            isSelectedColor = viewModel.findColorIndex()
        }
        
        .onTapGesture {
            hideKeyboard()
        }
        
        // MARK: side
        .navigationTitle(viewModel.selectedCycleItem.title)
        .navigationBarTitleDisplayMode(.inline)
        
        .popupSettingToolbar(
            cancelAction:  { showPopup.toggle() },
            action:  {  },
            completeAction: {
                
            }
        ) // popupSettingToolbar
    } // body
}

// MARK: - DetailTimerCycleItemCell
struct PopupItemColor: View {
    // MARK: Object
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    // MARK: State
    @State private var isSelectedColor: Int = 0
    
    // MARK: Binding
    @Binding var timerCycleList: [DetailItem]
    @Binding var selectedTimerCycleIndex: Int
    @Binding var showPopup: Bool
    
    // MARK: Main
    var body: some View {
        NavigationView {
            ColorSegmentedButton(selectedIndex: $isSelectedColor)
        }
        .navigationBasicToolbar(backAction: {}, title: "")
        
    }
}


//struct DetailTimerMovementsSet_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailTimerMovementsSet()
//            .environmentObject(DetailViewModel.shared)
//    }
//}
