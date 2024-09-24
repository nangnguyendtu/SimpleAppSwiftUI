import Foundation

struct TabItem {
    let title: String
}

class FirstViewModel: ObservableObject {
    @Published var tabItem = [
        TabItem(title: "Item1"),
        TabItem(title: "Item2"),
        TabItem(title: "Item3"),
        TabItem(title: "Item4"),
        TabItem(title: "Item5"),
        TabItem(title: "Item6"),
        TabItem(title: "Item7"),
        TabItem(title: "Item8"),
        TabItem(title: "Item9"),
    ]
    @Published var indexTabItemSelected = 0
}
