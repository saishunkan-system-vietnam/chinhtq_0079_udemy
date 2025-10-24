import SwiftUI

struct GrantAppRegisteredView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject private var appbarState: AppbarState
  @Environment(\.appSafeAreaInsets) private var insets
  @State private var visiblity = false
  
  var body: some View {
    ScrollView {
      Spacer().frame(height: 35)
      Image("IconDone")
        .resizable()
        .scaledToFit()
        .frame(width: 130, height: 130)
      Spacer().frame(height: 10)
      Text("申請が完了しました")
        .font(.system(size: 18, weight: .bold))
        .foregroundStyle(.colorLink)
      Spacer().frame(height: 40)
      VStack {
        Text("●申請対象外：2枚")
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.system(size: 16, weight: .bold))
        HStack(spacing: 0) {
          Text("過去申請済み：2枚").font(.system(size: 14))
          Spacer()
          Button("明細を非表示") {
            withAnimation(.spring(response: 0.28, dampingFraction: 0.86)) {
              visiblity.toggle()
            }
          }.buttonStyle(StyleButtonWithBackground(width: 90, minHeight: 25, radius: 30, fontSize: 11, fontWeight: .regular))
        }.frame(maxWidth: .infinity).padding(.horizontal, 20)
        if visiblity {
          Spacer().frame(height: 10)
          ScrollView {
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
          }.scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
            .frame(height: 300)
            .padding(.horizontal, 20)
            .transition(.asymmetric(
              insertion: .opacity.combined(with: .scale(scale: 0.98, anchor: .top)),
              removal: .opacity.combined(with: .scale(scale: 0.92, anchor: .top))
            ))
            .zIndex(1)
            .clipped()
        }
        Spacer().frame(height: 30)
        Button("メインメニューへ") {
          router.toRoot(RouteRoot.home)
        }.buttonStyle(StyleButtonWithBackground(width: 220, minHeight: 50, radius: 30))
        Spacer().frame(height: insets.bottom > 0 ? 0 : 20)
      }.padding(.horizontal, 10)
    }.scrollIndicators(.hidden)
      .scrollBounceBehavior(.basedOnSize)
      .onAppear() {
        appbarState.title = "完了"
        appbarState.isBack = false
      }.frame(maxHeight: .infinity, alignment: .top)
      .appbar()
  }
}

#Preview {
  GrantAppRegisteredView()
}
