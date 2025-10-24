import SwiftUI

struct HomeView: View {
  private var drawerTitles = ["プライバシーポリシー","ライセンス","利用規約","ログアウト"]
  @State private var showDrawer = false
  @State private var showAlert = false
  
  @EnvironmentObject var appbarState: AppbarState
  @EnvironmentObject var router: AppRouter
  @Environment(\.screenSize) private var size
  @Environment(\.appSafeAreaInsets) private var insets
  @Environment(\.openURL) private var openURL
  
  var body: some View {
    DrawerContainer(isOpen: $showDrawer) {
      VStack {
        ZStack {
          VStack(alignment: .leading) {
            Text("RYU00")
              .font(.system(size: 15, weight: .bold))
              .foregroundStyle(.white)
            Spacer()
            Text("ID:00000057")
              .font(.system(size: 15))
              .foregroundStyle(.white)
            Text("みやぎ宿泊割キャンペーン")
              .font(.system(size: 15, weight: .bold))
              .foregroundStyle(.white)
          }.padding(.leading, 20)
            .padding(.bottom, 10)
            .padding(.top, 7)
        }.frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
          .background(.colorPrimary)
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 0.0) {
            ForEach(drawerTitles.indices, id: \.self) { i in
              Button {
                if i == 0, let url = URL(string: "https://www.denso-wave.com/ja/privacy/") {
                  openURL(url)
                } else if i == 1 {
                  router.to(Route.license)
                } else if i == 2 {
                  router.to(Route.termsOfService)
                } else {
                  showAlert = true
                }
              } label: {
                Text(drawerTitles[i])
                  .font(.system(size: 16, weight: .medium))
                  .foregroundStyle(.black.opacity(0.7))
                  .padding(20)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
            }
          }.frame(maxHeight: size.height - 150)
        }.scrollIndicators(.hidden)
          .scrollBounceBehavior(.basedOnSize)
          .overlay(alignment: .bottom) {
            Text("Ver-1.0.1").font(.system(size: 14)).foregroundStyle(.gray.opacity(0.7))
            Spacer().frame(height: insets.bottom > 0 ? 0 : 40)
          }
      }
    } content: {
      ScrollView {
        LazyVStack(spacing: 17) {
          boxOption(text1: "地域クーポンの", text2: "補助金申請", text3: "を行います", textBtn: "補助金申請", color: .colorPrimary) {
            router.to(Route.registerGrantApp)
          }
          boxOption(text1: "補助金申請の", text2: "履歴", text3: "を確認します", textBtn: "履歴確認", color: .colorBG2) {
            router.to(Route.grantAppHistory)
          }
          boxOption(text1: "補助金申請の", text2: "精算状況", text3: "を確認します", textBtn: "精算状況確認", color: .colorBG3) {
            router.to(Route.grantAppStatus)
          }
          boxOption(text1: "補助金申請の", text2: "取り消し", text3: "を行います", textBtn: "取り消し", color: .colorBG4) {
            router.to(Route.cancelGrantApp)
          }
        }.padding(15)
      }.scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .onAppear() {
          appbarState.title = "メインメニュー"
          appbarState.background = .colorPrimary
          appbarState.leading = AnyView(
            Button { withAnimation { showDrawer.toggle() } } label: {
              Image(systemName: "line.3.horizontal").foregroundStyle(.white).font(.system(size: 23))
            }
          )
        }.appbar()
        .alert("ログアウト", isPresented: $showAlert) {
          Button("キャンセル", role: .cancel) {
            showAlert = false
          }
          Button("OK", role: .destructive) {
            router.toRoot(RouteRoot.login)
          }
        } message: {
          Text("ログアウトしてもよろしいですか？")
        }
    }
  }
  
  @ViewBuilder
  private func boxOption(text1: String, text2: String, text3: String, textBtn: String, color: Color, _ onAction: @escaping () -> Void) -> some View {
    VStack {
      Text(text1).font(.system(size: 15))
      HStack(alignment: .center, spacing: 0) {
        Text(text2).font(.system(size: 15, weight: .bold)).foregroundStyle(color)
        Text(text3).font(.system(size: 15))
      }
      Spacer().frame(height: 7)
      Button(textBtn, action: onAction)
        .buttonStyle(StyleButtonWithBackground(colorBG: color, width: 200))
    }.frame(maxWidth: .infinity, minHeight: 160)
      .background(color.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
}

struct DrawerContainer<Content: View, Drawer: View>: View {
  @Binding var isOpen: Bool
  var width: CGFloat = 300
  @ViewBuilder var drawer: () -> Drawer
  @ViewBuilder var content: () -> Content
  
  @Environment(\.screenSize) private var size
  
  var body: some View {
    ZStack {
      content().zIndex(0)
      
      if isOpen {
        Color.black.opacity(0.4)
          .ignoresSafeArea()
          .onTapGesture { withAnimation(.interactiveSpring(duration: 0.5)) { isOpen = false } }
          .transition(.opacity).zIndex(1)
      }
      
      drawer()
        .frame(width: width)
        .frame(maxHeight: .infinity)
        .background(.ultraThickMaterial)
        .shadow(radius: 12, x: 0, y: -10)
        .offset(x: isOpen ? -((size.width / 2) - (width / 2)) : -size.width)
        .transition(.move(edge: .leading))
        .animation(.interactiveSpring(duration: 0.5), value: isOpen).zIndex(2)
    }
  }
}

#Preview {
  HomeView()
}
