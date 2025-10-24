import SwiftUI

struct RegisterGrantAppView: View {
  @EnvironmentObject var router: AppRouter
  
    var body: some View {
      ScanGrantView(
        mainColor: .colorPrimary,
        title1: "地域クーポン",
        title2: "を読み取ってください\n※一度に読み取れるのは最大1,000枚です",
        buttonTitle: "確認画面へ",
        appbarTitle: "補助金申請") { values in 
          print("\(values)")
          router.to(Route.confirmGrantApp)
        }
    }
}

#Preview {
  RegisterGrantAppView()
}
