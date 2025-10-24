import SwiftUI

struct LoginAccountView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var showPass: Bool = false
  @State private var fieldRequire: [String] = ["", ""]
  
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject var appbarState: AppbarState
  @Environment(\.appSafeAreaInsets) private var insets
  
  var body: some View {
    VStack {
      Text("補助金申請\nポータルアカウントログイン")
        .multilineTextAlignment(.center)
        .font(.system(size: 15))
        .foregroundStyle(.colorPrimary)
      Spacer().frame(height: 20)
      VStack {
        TextField("メールアドレス", text: $email)
          .frame(maxWidth: .infinity)
          .frame(height: 60)
          .font(.system(size: 16))
          .keyboardType(.emailAddress)
          .textContentType(.emailAddress)
          .padding(.leading, 47)
          .overlay(alignment: .leading) {
            Image("IconMail")
              .resizable()
              .scaledToFit()
              .frame(width: 23, height: 23)
              .padding(.leading, 15)
          }.autoBorder(require: $fieldRequire[0])
        Spacer().frame(height: 15)
        Group {
          if showPass {
            TextField("パスワード", text: $password)
          } else {
            SecureField("パスワード", text: $password)
          }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .font(.system(size: 16))
        .textContentType(.password)
        .padding(.leading, 47)
        .overlay(alignment: .leading) {
          Image("IconPass")
            .resizable()
            .scaledToFit()
            .frame(width: 23, height: 23)
            .padding(.leading, 15)
        }
        .overlay(alignment: .trailing) {
          Image(systemName: !showPass ? "eye.fill" : "eye.slash.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 23, height: 23)
            .padding(.trailing, 15)
            .foregroundStyle(.colorPrimary)
            .gesture(
              TapGesture().onEnded {
                showPass = !showPass
              }
            )
        }.autoBorder(require: $fieldRequire[1])
        Spacer().frame(height: 25)
        Button("ログイン") {
          fieldRequire[0] = email.isEmpty ? "メールアドレスは空白のままにできません" : ""
          fieldRequire[1] = password.isEmpty ? "パスワードは空白にできません" : ""
          if !fieldRequire.contains(where: { !$0.isEmpty }) {
            router.toRoot(RouteRoot.home)
          }
        }
        .buttonStyle(StyleButtonWithBackground(radius: 30))
      }.padding(.horizontal, 30)
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
        appbarState.title = "ログイン"
        appbarState.leading = nil
      }.appbar()
      .overlay(alignment: .bottom) {
        HStack {
          Button("QRコードログインを\nご利用の場合はこちら") {
            router.off(RouteLogin.loginQR)
          }.buttonStyle(StyleButtonOutline())
           .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 0)
        }.padding(.horizontal, 40)
          .padding(.bottom, insets.bottom > 0 ? 0 : 25)
      }.ignoresSafeArea(.keyboard, edges: .bottom)
  }
}

private struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 16, weight: .bold))
      .frame(maxWidth: .infinity, maxHeight: 50)
      .background(.colorPrimary)
      .foregroundColor(.white)
      .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
      .opacity(configuration.isPressed ? 0.7 : 1)
  }
}

#Preview {
  LoginAccountView()
}
