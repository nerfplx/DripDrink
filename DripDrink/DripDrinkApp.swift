//
//  DripDrinkApp.swift
//  DripDrink
//
//  Created by Alexandr on 24.04.25.
//

import SwiftUI

@main
struct DripDrinkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
