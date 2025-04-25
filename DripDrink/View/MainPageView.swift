import SwiftUI

struct MainPageView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                PopularDrinksView()
                NewFoodView()
            }
            .background(Color("gray_custom"))
        }
    }
}

#Preview {
    MainPageView()
}
