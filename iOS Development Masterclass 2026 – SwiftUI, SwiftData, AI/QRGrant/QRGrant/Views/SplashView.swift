import SwiftUI

struct SplashView: View {
  @Environment(\.appSafeAreaInsets) private var insets
  
  var body: some View {
    ZStack {
      Color(uiColor: .colorPrimary).ignoresSafeArea()
      VStack {
        Image("Logo").resizable().scaledToFit().frame(maxWidth: 300, maxHeight: 300)
        Text("QR補助金申請App")
          .foregroundColor(.white)
          .font(.system(size: 17))
          .frame(maxWidth: 250, maxHeight: 40)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.white, lineWidth: 1.2)
          ).offset(y: 15)
      }
    }.transition(.identity)
     .overlay(alignment: .bottom) {
      Text("Ver-1.0.0").foregroundColor(.white).font(.system(size: 17))
      Spacer().frame(height: insets.bottom > 0 ? 0 : 40)
    }
  }
}

#Preview {
  SplashView()
}
