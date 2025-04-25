import SwiftUI

struct NewFoodView: View {
    let food: [ProductModel] = [
        ProductModel(name: "Сэндвич", image: "food", price: "180"),
        ProductModel(name: "Сэндвич", image: "food", price: "180"),
        ProductModel(name: "Сэндвич", image: "food", price: "180"),
        ProductModel(name: "Сэндвич", image: "food", price: "180")
    ]
    @State private var selectedFood: ProductModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Новое для тебя")
                .foregroundStyle(.white)
                .font(.title3)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(food, id: \.name) { food in
                        Button(action: {
                            selectedFood = food
                        }) {
                            ZStack(alignment: .bottomLeading) {
                                Image(food.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 400)
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                .frame(height: 120)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                                .offset(y: 30)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(food.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    HStack {
                                        Text(food.price)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                            }
                            .frame(width: 300, height: 400)
                            .background(.black)
                            .cornerRadius(12)
                            .shadow(radius: 4)
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
        
        
    }
}
