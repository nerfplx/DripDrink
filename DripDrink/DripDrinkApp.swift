import SwiftUI
import MapKit
import CoreLocation
import CoreData

@main
struct DripDrinkApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashScreenView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
