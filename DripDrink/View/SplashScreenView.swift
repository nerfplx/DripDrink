import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            LocationSelectionView()
        } else {
            VStack {
                Image("coffee_splash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding()
                    .transition(.scale)
                Text("Вдохновение начинается с кофе")
                    .font(.title)
                    .padding(.top, 20)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
