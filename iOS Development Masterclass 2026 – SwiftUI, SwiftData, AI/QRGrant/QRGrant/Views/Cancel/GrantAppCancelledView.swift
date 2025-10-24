import SwiftUI

struct GrantAppCancelledView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject private var appbarState: AppbarState
  @Environment(\.appSafeAreaInsets) private var insets
  
    var body: some View {
      VStack {
        Image("IconDone")
          .resizable()
          .scaledToFit()
          .frame(width: 130, height: 130)
        Spacer().frame(height: 20)
        Text(richText()).multilineTextAlignment(.center)
      }.onAppear() {
        appbarState.title = "完了"
        appbarState.isBack = false
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .appbar()
        .overlay(alignment: .bottom) {
          Button("メインメニューへ") {
            router.toRoot(RouteRoot.home)
          }.buttonStyle(StyleButtonWithBackground(colorBG: .colorBG4, width: 220, height: 50, radius: 30))
          Spacer().frame(height: insets.bottom > 0 ? 0 : 20)
        }
    }
  
  func richText() -> AttributedString {
      var s = AttributedString("補助金申請の取り消しが\n完了しました")
      s.font = .system(size: 18)
      if let r1 = s.range(of: "取り消し") {
        s[r1].foregroundColor = .colorBG4
      }
      return s
    }
}

#Preview {
    GrantAppCancelledView()
}
