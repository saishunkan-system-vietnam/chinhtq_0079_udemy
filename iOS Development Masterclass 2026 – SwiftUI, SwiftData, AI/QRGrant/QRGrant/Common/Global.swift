import SwiftUI

private struct AppSafeAreaKey: EnvironmentKey {
  static let defaultValue: EdgeInsets = .init()
}

extension EnvironmentValues {
  var appSafeAreaInsets: EdgeInsets {
    get { self[AppSafeAreaKey.self] }
    set { self[AppSafeAreaKey.self] = newValue }
  }
}

private struct ScreenSize: EnvironmentKey {
  static let defaultValue: CGSize = .init()
}

extension EnvironmentValues {
  var screenSize: CGSize {
    get { self[ScreenSize.self] }
    set { self[ScreenSize.self] = newValue }
  }
}
