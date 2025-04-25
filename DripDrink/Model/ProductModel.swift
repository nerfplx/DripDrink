import SwiftUI

struct ProductModel: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: String
}
