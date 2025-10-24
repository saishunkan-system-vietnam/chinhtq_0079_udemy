import SwiftUI

struct GrantAppDetailView: View {
  @EnvironmentObject var appbarState: AppbarState
  @State private var visiblity = false
  
  var body: some View {
    VStack {
      VStack(spacing: 0) {
        infor(title: "申請枚数", price: "3枚")
        infor(title: "申請額", price: "4,000円")
      }.frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.bottom, 15)
        .background(.colorBorder.opacity(0.3))
      Spacer().frame(height: 20)
      HStack {
        Text("地域クーポン一覧")
          .font(.system(size: 14))
        Spacer()
        Button("明細を非表示") {
          withAnimation(.spring(response: 0.28, dampingFraction: 0.86)) {
            visiblity.toggle()
          }
        }.buttonStyle(StyleButtonWithBackground(colorBG: .colorBG2, width: 95, height: 27, radius: 30, fontSize: 11, fontWeight: .regular))
      }.padding(.horizontal, 20)
      if visiblity {
        Spacer().frame(height: 10)
        ScrollView {
          ForEach(0..<10, id: \.self) { i in
            HStack(spacing: 3) {
              Text("000\(i+1) : 000000\(i)")
                .font(.system(size: 16))
              Text("(2023-02-2\(i) 1\(i):50:18)")
                .font(.system(size: 12)).padding(.top, 3)
            }.frame(maxWidth: .infinity, minHeight: 45, alignment: .leading)
              .padding(.horizontal, 10)
              .overlay(
                RoundedRectangle(cornerRadius: 0)
                  .strokeBorder(.colorBorder, lineWidth: 1.2)
              )
          }
        }.scrollIndicators(.hidden)
          .scrollBounceBehavior(.basedOnSize)
          .frame(height: 300)
          .padding(.horizontal, 35)
          .transition(.asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 0.98, anchor: .top)),
            removal: .opacity.combined(with: .scale(scale: 0.92, anchor: .top))
          ))
          .zIndex(1)
          .clipped()
      }
    }.onAppear() {
      appbarState.title = "申請詳細"
    }.frame(maxHeight: .infinity, alignment: .top)
      .appbar()
  }
  
  @ViewBuilder
  private func infor(title: String, price: String) -> some View {
    HStack {
      Text(title).font(.system(size: 14))
      Spacer()
      Text(price).font(.system(size: 18, weight: .bold))
    }.padding(.vertical, 15)
      .padding(.horizontal, 5)
      .overlay(alignment: .bottom) {
        Color(uiColor: .colorGrayBG).frame(height: 1).opacity(0.7)
      }
  }
}

#Preview {
  GrantAppDetailView()
}
