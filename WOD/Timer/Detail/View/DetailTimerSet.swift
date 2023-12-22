//
//  DetailTimerMovementsSet.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI


// MARK: - DetailTimerMovementsSet
struct DetailTimerMovementsSet: View {
    @EnvironmentObject var viewModel: DetailViewModel
    @StateObject var manager = InputManager()
    
    @State private var dynamicMovement: [DetailItem] = []
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                CustomTextField(text: $manager.movementText, defaultText: "Movement")
            } // VStack
        } // NavigationView
    }
}


struct DetailTimerMovementsSet_Previews: PreviewProvider {
    static var previews: some View {
        DetailTimerMovementsSet()
            .environmentObject(DetailViewModel.shared)
    }
}
