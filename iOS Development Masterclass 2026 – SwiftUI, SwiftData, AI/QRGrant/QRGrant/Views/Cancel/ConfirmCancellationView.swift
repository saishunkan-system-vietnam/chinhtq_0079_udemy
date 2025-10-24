import SwiftUI

struct ConfirmCancellationView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject private var appbarState: AppbarState
  @Environment(\.appSafeAreaInsets) private var insets
  @State private var visiblitys = [false,false]
  
    var body: some View {
      ScrollView {
        Spacer().frame(height: 20)
        Text("4枚")
          .font(.system(size: 18, weight: .bold))
          .foregroundStyle(.colorLink)
        Text("読み取りました").font(.system(size: 16))
        Spacer().frame(height: 32)
        pulldownView(id: 0, title: "●取消対象：10枚", titleBtn: "明細を表示")
        Spacer().frame(height: 17)
        pulldownView(id: 1, title: "●取消対象外：10枚", titleBtn: "明細を表示")
        Spacer().frame(height: 40)
        Button("申請取り消し") {
          router.to(Route.grantAppCancelled)
        }.buttonStyle(StyleButtonWithBackground(colorBG: .colorBG4, width: 200, minHeight: 50, radius: 30, paddingH: 20, iconLeading: "IconConfirm"))
        Spacer().frame(height: insets.bottom > 0 ? 0 : 15)
      }.scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .onAppear() {
          appbarState.title = "内容確認"
        }.appbar()
    }
  
  @ViewBuilder
  private func pulldownView(id: Int, title: String, titleBtn: String) -> some View {
    VStack {
      HStack {
        Text(title)
          .font(.system(size: 16, weight: .bold))
        Spacer()
        Button(titleBtn) {
          withAnimation(.spring(response: 0.28, dampingFraction: 0.86)) {
            visiblitys[id].toggle()
          }
        }.buttonStyle(StyleButtonWithBackground(width: 90, minHeight: 25, radius: 30, fontSize: 11, fontWeight: .regular))
      }
      if visiblitys[id] {
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
    }.padding(.horizontal, 20)
  }
}

#Preview {
    ConfirmCancellationView()
}
