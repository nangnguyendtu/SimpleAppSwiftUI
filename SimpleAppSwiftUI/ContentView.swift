import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        TabBarController { index in
            if self.selectedTabIndex == index {
                print("Reselected tab index: \(self.selectedTabIndex) == \(index)")
            } else {
                print("Selected tab index: \(self.selectedTabIndex) == \(index)")
            }
            self.selectedTabIndex = index
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

struct TabBarController: UIViewControllerRepresentable {
    var onTabChange: (Int) -> Void
    
    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = context.coordinator
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.backgroundColor = .white
        let firstView = UIHostingController(rootView: FirstView())
        firstView.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "1.circle"), tag: 0)
        let secondView = UIHostingController(rootView: SecondView())
        secondView.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "2.circle"), tag: 1)
        tabBarController.viewControllers = [firstView, secondView]
        return tabBarController
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
    }
    
    class Coordinator: NSObject, UITabBarControllerDelegate {
        var parent: TabBarController
        init(_ parent: TabBarController) {
            self.parent = parent
        }
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
                parent.onTabChange(index)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
