import SwiftUI

struct GrantAppHistoryView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject private var appbarState: AppbarState
  @State private var tabIndex = 0
  
  enum Tab: Int { case today = 0, search = 1 }
  @State private var tab: Tab = .today
  
  var body: some View {
    VStack {
      TabBarView(titles: ["今日", "詳細検索"], selection: Binding(
        get: { tab.rawValue }, set: { tab = Tab(rawValue: $0) ?? .today }
      ))
      
      ScrollView {
        switch tab {
        case .today:
          InforTodayView()
        case .search:
          AdvancedSearchView()
        }
      }.scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
    }.onAppear() {
      appbarState.leading = nil
      appbarState.title = "履歴確認"
      appbarState.background = .colorBG2
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
      .appbar()
  }
}

struct TabBarView: View {
  let titles: [String]
  @Binding var selection: Int
  
  @Environment(\.displayScale) private var scale
  private var hairline: CGFloat { 1 / scale }   // 1 pixel
  
  var body: some View {
    GeometryReader { geo in
      let tabW = geo.size.width / CGFloat(titles.count)
      
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          ForEach(titles.indices, id: \.self) { i in
            Button {
              withAnimation(.easeInOut(duration: 0.22)) { selection = i }
            } label: {
              Text(titles[i])
                .font(.system(size: 18))
                .foregroundStyle(.colorLink)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .contentShape(Rectangle())
                .background(selection == i ? .colorLink.opacity(0.05) : .clear)
                .animation(.easeInOut(duration: 0.5), value: selection)
            }
            .frame(width: tabW)
            .buttonStyle(.plain)
          }
        }
        ZStack(alignment: .leading) {
          Rectangle()
            .fill(Color.black.opacity(0.3))
            .frame(height: 3)
          
          Rectangle()
            .fill(.colorLink)
            .frame(width: tabW, height: 3)
            .offset(x: CGFloat(selection) * tabW)
            .animation(.easeInOut(duration: 0.22), value: selection)
        }
      }
    }
    .frame(height: 50)
    .background(Color.white)
  }
}

#Preview {
  GrantAppHistoryView()
}
