import SwiftUI

struct LoginQRView: View {
  @StateObject private var controllerSC = QRScannerController()
  
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject var appbarState: AppbarState
  @Environment(\.screenSize) private var size
  @Environment(\.appSafeAreaInsets) private var insets
  
  var body: some View {
    VStack {
      Spacer().frame(height: 23)
      Text("ログイン用QRコード")
        .font(.system(size: 22, weight: .medium))
        .foregroundStyle(.colorLink)
      Spacer().frame(height: 3)
      Text("を読み取ってください")
        .font(.system(size: 16))
      Spacer().frame(height: 15)
      QRScannerView(controller: controllerSC) { value in
        print("scanner[\(value)]")
      }.onAppear { controllerSC.start() }
       .onDisappear { controllerSC.stop() }
      Spacer().frame(height: 25)
      HStack {
        Button("ポータルアカウントを\nご利用の場合はこちら") {
          router.off(RouteLogin.loginAccount)
        }.buttonStyle(StyleButtonOutline())
          .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 0)
      }.padding(.horizontal, 40)
      Spacer().frame(height: insets.bottom > 0 ? 0 : 25)
    }.onAppear {
      appbarState.title = "QRコードログイン"
      appbarState.leading = nil
    }.appbar()
  }
}

#Preview {
  LoginQRView()
    .environmentObject(AppRouter())
    .environmentObject(AppbarState())
}
