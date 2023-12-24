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
    
    @State private var isChange: Bool = false
    
    @State private var dynamicCycleList: [DetailItem] = [DetailItem(title: "Movement"), DetailItem(title: "Rest", time: 10),  DetailItem(title: "Rest", time: 10),  DetailItem(title: "Rest", time: 10)]
    

    
    @Binding var rootView: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dynamicCycleList) { item in
                    Text(item.title)
                }
                .onDelete(perform: removeList)
                .onMove(perform: moveList)
            } // List
            .navigationBarBackButtonHidden()
            .toolbar {
                EditButton()
            }
            .navigationBasicToolbar(
                backAction: { rootView.toggle() },
                title: "Cycle Set"
            ) // navigationBasicToolbar
        } // NavigationView
    }
    
    func removeList(at offsets: IndexSet) {
        dynamicCycleList.remove(atOffsets: offsets)
    }
    func moveList(from source: IndexSet, to destination: Int) {
        dynamicCycleList.move(fromOffsets: source, toOffset: destination)
    }
}

struct DetailTimerCycleSet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerCycleSet(rootView: .constant(false))
            .environmentObject(DetailViewModel.shared)
    }
}
