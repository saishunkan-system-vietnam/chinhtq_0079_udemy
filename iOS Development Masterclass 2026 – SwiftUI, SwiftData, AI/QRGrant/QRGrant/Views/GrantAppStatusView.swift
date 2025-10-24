import SwiftUI

struct GrantAppStatusView: View {
  @EnvironmentObject var appbarState: AppbarState
  @EnvironmentObject var router: AppRouter
  
  var body: some View {
    ZStack {
      ScrollView {
        Spacer().frame(height: 12)
        ForEach(0..<10, id: \.self) { _ in
          VStack(alignment: .leading, spacing: 0) {
            Text("PTW宮城締め確認").font(.system(size: 14, weight: .bold))
            Text("読み取り期間：2022-09-14まで").font(.system(size: 14))
            Text("ステータス：支払完了").font(.system(size: 14))
            Text("精算枚数：0枚").font(.system(size: 14))
            Text("精算額：0円").font(.system(size: 14))
          }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
            .padding(.top, 3)
            .overlay(alignment: .bottom) {
              Rectangle()
                  .fill(.colorBorder)
                  .frame(height: 1)
            }
        }
      }.scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .padding(.horizontal, 20)
    }.onAppear() {
      appbarState.title = "精算状況確認"
      appbarState.leading = nil
      appbarState.background = .colorBG3
      appbarState.isBack = true
      appbarState.onBack = {
        appbarState.background = .colorPrimary
        router.pop()
      }
    }.appbar()
  }
}

#Preview {
  GrantAppStatusView()
}
