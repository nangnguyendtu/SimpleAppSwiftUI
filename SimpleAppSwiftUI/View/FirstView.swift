import SwiftUI

struct FirstView: View {
    @ObservedObject private var viewModel = FirstViewModel()
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< viewModel.tabItem.count, id: \.self) { index in
                            tabItem(title: viewModel.tabItem[index].title, isSelected: viewModel.indexTabItemSelected == index)
                                .onTapGesture {
                                    viewModel.indexTabItemSelected = index
                                }
                        }
                    }
                }
                .onChange(of: viewModel.indexTabItemSelected) { _, value in
                    withAnimation {
                        proxy.scrollTo(
                            value,
                            anchor: value == viewModel.tabItem.count - 1 ? .trailing : .center
                        )
                    }
                }
            }
            contentTab()
        }
    }
    
    func tabItem(title: String, isSelected: Bool) -> some View {
        Text(title)
            .frame(width: 90, height: 30)
            .foregroundColor(isSelected ? Color.black : Color.gray)
            .background(isSelected ? Color.white : Color.gray.opacity(0.5))
    }
    
    func contentTab() -> some View {
        TabView(selection: $viewModel.indexTabItemSelected) {
            ForEach(viewModel.tabItem.indices, id: \.self) { index in
                switch index {
                case 0:
                    Color.red.ignoresSafeArea()
                case 1:
                    Color.yellow.ignoresSafeArea()
                default:
                    Color.white.ignoresSafeArea()
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
