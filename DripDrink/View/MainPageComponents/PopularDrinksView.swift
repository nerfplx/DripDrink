import SwiftUI

struct PopularDrinksView: View {
    let drinks: [ProductModel] = [
        ProductModel(name: "Эспрессо", image: "cap", price: "220"),
        ProductModel(name: "Капучино", image: "cap", price: "220"),
        ProductModel(name: "Латте", image: "cap", price: "220"),
        ProductModel(name: "Флэт Уайт", image: "cap", price: "220")
    ]
    @State private var selectedDrink: ProductModel?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Популярные напитки")
                .foregroundStyle(.white)
                .font(.title3)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(drinks, id: \.name) { drink in
                        Button(action: {
                            selectedDrink = drink
                        }) {
                            VStack(alignment: .leading) {
                                Image(drink.image)
                                    .resizable()
                                    .scaledToFill()
                                Text(drink.name)
                                    .font(.footnote)
                                    .foregroundStyle(.white)
                                Spacer()
                                HStack {
                                    Text(drink.price)
                                        .font(.footnote)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding()
                            .frame(width: 100, height: 180)
                            .background(.black)
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding()
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .background(Color("gray_custom"))
        .sheet(item: $selectedDrink) { drink in
            CoffeeModalView(drink: drink)
        }
    }
}
