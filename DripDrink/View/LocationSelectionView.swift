import SwiftUI
import _MapKit_SwiftUI
import CoreLocation

struct LocationSelectionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedPlace: CoffeePlaceModel?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
            span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
        )
    )
    @StateObject private var locationManager = LocationManager()

    let coffeePlaces: [CoffeePlaceModel] = [
        CoffeePlaceModel(name: "Кофейня на Арбате", coordinate: CLLocationCoordinate2D(latitude: 55.7522200, longitude: 37.6155600), city: "Москва"),
        CoffeePlaceModel(name: "Кофе в центре", coordinate: CLLocationCoordinate2D(latitude: 59.9342802, longitude: 30.3350986), city: "Санкт-Петербург"),
        CoffeePlaceModel(name: "Кофе и точка", coordinate: CLLocationCoordinate2D(latitude: 56.8389261, longitude: 60.6057025), city: "Екатеринбург"),
        CoffeePlaceModel(name: "Чашка счастья", coordinate: CLLocationCoordinate2D(latitude: 43.1056200, longitude: 131.8735300), city: "Владивосток")
    ]

    @State private var goToMenu = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Map(position: $cameraPosition) {
                    ForEach(coffeePlaces) { place in
                        Annotation(place.name, coordinate: place.coordinate) {
                            Button(action: {
                                selectedPlace = place
                            }) {
                                VStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.brown)
                                        .font(.title)
                                    Text(place.name)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)

                Button(action: {
                    if let location = locationManager.userLocation {
                        cameraPosition = .region(MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        ))
                    }
                }) {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                        .padding()
                }
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding()
            }
            .navigationTitle("Выберите точку самовывоза")
            .onReceive(locationManager.$userLocation) { location in
                if let location = location {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    ))
                }
            }
            .sheet(item: $selectedPlace) { place in
                VStack(spacing: 20) {
                    Text("Вы выбрали точку:")
                    Text(place.name)
                        .bold()
                    Text("Город: \(place.city)")
                    Button("Подтвердить") {
                        let selection = UserSelection(context: viewContext)
                        selection.city = place.city
                        selection.placeName = place.name

                        do {
                            try viewContext.save()
                            selectedPlace = nil
                            goToMenu = true
                        } catch {
                            print("Ошибка сохранения: \(error.localizedDescription)")
                        }
                    }
                    .padding()
                    .background(.brown)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
            .navigationDestination(isPresented: $goToMenu) {
                MainPageView()
            }
        }
    }
}
