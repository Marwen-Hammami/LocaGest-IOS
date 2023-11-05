//
//  LocaGestApp.swift
//  LocaGest
//
//  Created by Karim Hammami on 05/11/2023.
//

import SwiftUI

@main
struct LocaGestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
