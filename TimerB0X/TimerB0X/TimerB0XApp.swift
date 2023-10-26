//
//  TImerB0XApp.swift
//  TImerB0X
//
//  Created by KyungHeon Lee on 2023/10/25.
//

import SwiftUI

@main
struct TImerB0XApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
