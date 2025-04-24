import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserSelection.city, ascending: true)],
        animation: .default)
    private var userSelections: FetchedResults<UserSelection>

    var body: some View {
        NavigationView {
            List {
                ForEach(userSelections) { selection in
                    NavigationLink {
                        VStack {
                            Text("Вы выбрали точку:")
                            Text(selection.placeName ?? "Не указано")
                                .bold()
                            Text("Город: \(selection.city ?? "Не указан")")
                        }
                    } label: {
                        Text("\(selection.placeName ?? "Не указано") - \(selection.city ?? "Не указан")")
                    }
                }
                .onDelete(perform: deleteSelections)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addSelection) {
                        Label("Добавить точку", systemImage: "plus")
                    }
                }
            }
            Text("Выберите точку самовывоза")
        }
    }

    private func addSelection() {
        withAnimation {
            let newSelection = UserSelection(context: viewContext)
            newSelection.city = "Москва"
            newSelection.placeName = "Кофейня на Арбате"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteSelections(offsets: IndexSet) {
        withAnimation {
            offsets.map { userSelections[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
