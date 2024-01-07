//
//  SimpleRecordCell.swift
//  Timer
//
//  Created by lkh on 12/22/23.
//

import SwiftUI

// MARK: - SimpleRecordCell
struct SimpleRecordCell: View {
    var cell: SimpleRound
    var idx: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(idx + 1) Round")
                .font(.title)
            HStack(alignment: .center, spacing: 0) {
                Text("Movements:\n\(cell.movement.asTimestamp)")
                //recordMovements()
                Spacer()
                Text("Rest:\n\(cell.rest.asTimestamp)")
                //recordRest()
            } // HStack
        } // VStack
    } // body
    
    // MARK: - ViewBuilder
    // ...
    // MARK: - recordMovements
    @ViewBuilder
    private func recordMovements() -> some View {
        Text("Movements: \(cell.movement.asTimestamp)")
            .font(.headline)
        
        Text("Start: \(cell.date.movementStart)")
            .font(.subheadline)
        
        Text("Complted: \(cell.date.movementComplted)")
            .font(.subheadline)
    }
    
    // MARK: - recordRest
    @ViewBuilder
    private func recordRest() -> some View {
        Text("Rest: \(cell.rest.asTimestamp)")
            .font(.headline)
        
        Text("Start: \(cell.date.restStart)")
            .font(.subheadline)

        Text("Complted: \(cell.date.restComplted)")
            .font(.subheadline)
    }
}

