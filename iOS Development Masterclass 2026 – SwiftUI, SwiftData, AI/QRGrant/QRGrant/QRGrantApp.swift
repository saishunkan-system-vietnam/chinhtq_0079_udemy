import SwiftUI
import SwiftData

@main
struct QRGrantApp: App {
  @StateObject private var router = AppRouter()
  @StateObject private var appbar  = AppbarState()
  
  var body: some Scene {
    WindowGroup {
      GeometryReader { proxy in
        let size = proxy.size
        let insets = proxy.safeAreaInsets
        
        RootView()
          .environmentObject(router)
          .environmentObject(appbar)
          .environment(\.appSafeAreaInsets, proxy.safeAreaInsets)
          .environment(\.screenSize, CGSize(width: (size.width - insets.leading - insets.trailing),
                                            height: (size.height - insets.top - insets.bottom)))
      }
    }
  }
}

struct RootView: View {
  @EnvironmentObject var router: AppRouter
  
  var body: some View {
    ZStack {
      switch router.initalRoute {
      case .splash:
        SplashView()
          .onAppear { handleCheckLogin() }
      case .login:
        NavigationStack(path: $router.path) {
          LoginView().navigationDestination(for: RouteLogin.self) { route in
            router.loginRoutes(for: route)
          }
        }
      case .home:
        NavigationStack(path: $router.path) {
          HomeView().navigationDestination(for: Route.self) { route in
            router.routes(for: route)
          }
        }
      }
    }.overlay(
      UnFocusTextField()
        .ignoresSafeArea()
        .allowsHitTesting(false)
    ).foregroundStyle(.black.opacity(0.7))
  }
  
  func handleCheckLogin() {
    Task {
      try await Task.sleep(nanoseconds: 2_000_000_000)
      router.initalRoute = .login
    }
  }
}
