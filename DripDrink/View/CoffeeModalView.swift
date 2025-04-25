import SwiftUI

struct CoffeeModalView: View {
    let drink: ProductModel
    @State private var selectedSize: String = "M"
    
    var body: some View {
        VStack {
            Image(drink.image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 250)
                .padding()
            
            VStack(spacing: 16) {
                Text(drink.name)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                
                Spacer()
                
                HStack(spacing: 16) {
                    HStack(spacing: 8) {
                        ForEach(["S", "M", "L"], id: \.self) { size in
                            Text(size)
                                .font(.subheadline)
                                .padding(10)
                                .background(selectedSize == size ? Color.black : Color.clear)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .scaleEffect(selectedSize == size ? 1.2 : 0.9)
                                .animation(.easeInOut(duration: 0.2), value: selectedSize)
                                .onTapGesture {
                                    selectedSize = size
                                }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(24)
                    
                    Button(action: {
                        print("Добавлен напиток: \(drink.name), размер: \(selectedSize)")
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                            Text(drink.price)
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(.blue)
                        .cornerRadius(24)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(24)
                .shadow(radius: 3)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color("gray_custom"))
    }
}


#Preview {
    CoffeeModalView(drink: ProductModel(name: "cap", image: "cap", price: "220"))
}
