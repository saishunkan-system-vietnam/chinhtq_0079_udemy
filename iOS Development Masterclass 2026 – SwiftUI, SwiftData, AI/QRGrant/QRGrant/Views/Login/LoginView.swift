import SwiftUI

struct LoginView: View {
  @EnvironmentObject var router: AppRouter
  @Environment(\.appSafeAreaInsets) private var insets
  
  var body: some View {
    VStack {
      Image("LogoRound")
        .resizable()
        .scaledToFill()
        .frame(maxWidth: 170, maxHeight: 170)
      Spacer().frame(height: 25)
      Text("QR補助金申請App")
        .foregroundColor(.colorPrimary)
        .font(.system(size: 16))
        .frame(maxWidth: 230, maxHeight: 40)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(.colorPrimary, lineWidth: 1.2)
        )
      Spacer().frame(height: 70)
      VStack {
        Button("ポータルアカウントでログイン") {
          router.to(RouteLogin.loginAccount)
        }.buttonStyle(StyleButtonWithBackground(height: 60, radius: 30, shadowOffsetY: 5))
        Spacer().frame(height: 15)
        Button("ログインQRコードでログイン") {
          router.to(RouteLogin.loginQR)
        }.buttonStyle(StyleButtonWithBackground(height: 60, radius: 30, shadowOffsetY: 5))
      }.padding(.horizontal, 30)
      Spacer().frame(height: 15)
      Text("ポータルアカウントとは、補助金申請ポータルサイトのメールアドレスとパスワードになります。\nログインQRコードは、補助金申請ポータルサイトの「アプリ用ログインQRコード」で表示できます。")
        .foregroundColor(.colorLink)
        .font(.system(size: 14, weight: .medium))
        .padding(.horizontal, 12)
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
     .overlay(alignment: .bottom) {
      Text("Ver-1.0.0").foregroundColor(.colorPrimary).font(.system(size: 17))
      Spacer().frame(height: insets.bottom > 0 ? 0 : 40)
    }
  }
}

#Preview {
  LoginView()
}
