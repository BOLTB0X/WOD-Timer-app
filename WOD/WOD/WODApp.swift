//
//  WODApp.swift
//  WOD
//
//  Created by KyungHeon Lee on 2023/10/22.
//

import SwiftUI

@main
struct WODApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
