import SwiftUI

struct ConfirmGrantAppView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject private var appbarState: AppbarState
  @Environment(\.appSafeAreaInsets) private var insets
  
    var body: some View {
      VStack {
        Spacer().frame(height: 20)
        Text("2枚")
          .font(.system(size: 18, weight: .bold))
          .foregroundStyle(.colorLink)
        Text("読み取りました").font(.system(size: 16))
        VStack(alignment: .leading) {
          Text("明細:").font(.system(size: 14))
          ScrollView {
            Spacer().frame(height: 15)
            ForEach(0..<10, id: \.self) { i in
              Text("000\(i+1) : 000000\(i)")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, minHeight: 45, alignment: .leading)
                .padding(.horizontal, 10)
                .overlay(
                  RoundedRectangle(cornerRadius: 0)
                    .strokeBorder(.colorBorder, lineWidth: 1.2)
                )
            }
            Spacer().frame(height: 15)
          }.scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            .overlay(
              RoundedRectangle(cornerRadius: 0)
                .stroke(.black.opacity(0.6), lineWidth: 1.3)
            )
        }.padding(.horizontal, 20)
        Spacer().frame(height: 20)
        Button("申請") {
          router.to(Route.grantAppRegistered)
        }.buttonStyle(StyleButtonWithBackground(colorBG: .colorPrimary, width: 200, height: 50, radius: 30, paddingH: 20, iconLeading: "IconConfirm"))
        Spacer().frame(height: insets.bottom > 0 ? 0 : 15)
      }.onAppear() {
        appbarState.title = "内容確認"
      }.frame(maxHeight: .infinity, alignment: .top)
        .appbar()
    }
}

#Preview {
  ConfirmGrantAppView()
}
