import Foundation
import CoreLocation

struct CoffeePlaceModel: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let city: String
}
