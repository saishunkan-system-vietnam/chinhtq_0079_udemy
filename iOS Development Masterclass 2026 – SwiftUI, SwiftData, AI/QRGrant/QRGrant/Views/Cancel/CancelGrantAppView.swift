import SwiftUI

struct CancelGrantAppView: View {
  @EnvironmentObject var router: AppRouter
  
    var body: some View {
      ScanGrantView(
        mainColor: .colorBG4,
        title1: "申請を取り消す",
        title2: "地域クーポン",
        title3: "を読み取ってください\n※一度に読み取れるのは最大1,000枚です",
        buttonTitle: "確認画面へ",
        appbarTitle: "取り消し") { values in
          print("\(values)")
          router.to(Route.confirmCancellation)
        }
    }
}

#Preview {
  CancelGrantAppView()
}
