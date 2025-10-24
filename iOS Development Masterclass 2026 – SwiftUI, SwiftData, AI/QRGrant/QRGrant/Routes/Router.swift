import SwiftUI

@MainActor
final class AppRouter: ObservableObject {
  @Published var initalRoute: RouteRoot = .splash
  @Published var path = NavigationPath()
  
  @ViewBuilder
  func loginRoutes(for route: RouteLogin) -> some View {
    switch route {
    case .loginAccount:
      LoginAccountView()
    case .loginQR:
      LoginQRView()
    }
  }
  
  @ViewBuilder
  func routes(for route: Route) -> some View {
    switch route {
    case .registerGrantApp:
      RegisterGrantAppView()
      
    case .confirmGrantApp:
      ConfirmGrantAppView()
      
    case .grantAppRegistered:
      GrantAppRegisteredView()
      
    case .cancelGrantApp:
      CancelGrantAppView()
      
    case .confirmCancellation:
      ConfirmCancellationView()
      
    case .grantAppCancelled:
      GrantAppCancelledView()
      
    case .grantAppStatus:
      GrantAppStatusView()
      
    case .grantAppHistory:
      GrantAppHistoryView()
      
    case .couponScan:
      CouponScanView()
      
    case .grantAppDetail:
      GrantAppDetailView()
      
    case .license:
      LicenseView()
      
    case .termsOfService:
      TermsOfServiceView()
    }
  }
}

extension AppRouter {
  func to(_ name: any Hashable) { path.append(name) }
  
  func off(_ name: any Hashable) { 
    path.removeLast()
    path.append(name)
  }
  
  func pop() { path.removeLast() }
  
  func toRoot(_ name: RouteRoot) {
    initalRoute = name
    path = NavigationPath()
  }
}
