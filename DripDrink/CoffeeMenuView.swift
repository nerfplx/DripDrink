import SwiftUI

struct CoffeeMenuView: View {
    let drinks = [
        (name: "Эспрессо", image: "cap"),
        (name: "Капучино", image: "cap"),
        (name: "Латте", image: "cap"),
        (name: "Флэт Уайт", image: "cap")
    ]

    var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Меню кофе")
                        .font(.largeTitle)
                        .bold()
                    
                    ForEach(drinks, id: \.name) { drink in
                        VStack {
                            Image(drink.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                            Text(drink.name)
                                .font(.headline)
                            Button("Заказать") {
                                print("Заказ: \(drink.name)")
                            }
                            .padding(8)
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                }
                .padding()
            }
        }
}
