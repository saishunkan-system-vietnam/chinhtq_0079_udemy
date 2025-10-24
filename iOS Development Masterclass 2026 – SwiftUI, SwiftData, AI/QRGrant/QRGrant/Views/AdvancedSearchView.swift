import SwiftUI

struct AdvancedSearchView: View {
  @EnvironmentObject var router: AppRouter
  
  @State private var quantity = ""
  @State private var fieldRequire: String = ""
  @State private var selected: Options = .option1
  @State var from = Date()
  @State var to = Date()
  
  var body: some View {
    VStack {
      Spacer().frame(height: 10)
      VStack(alignment: .leading) {
        radioButton(value: Options.option1, groupValue: $selected, title: Options.option1.rawValue)
        DateSelect(value: $from, selected: selected == .option1)
        Text("〜")
          .frame(height: 30)
          .frame(maxWidth: .infinity, alignment: .center)
          .font(.system(size: 14, weight: .medium))
          .foregroundStyle(selected == .option1 ? .black.opacity(0.7) : .colorGrayBG.opacity(0.8))
        DateSelect(value: $to, selected: selected == .option1)
        Spacer().frame(height: 15)
        radioButton(value: Options.option2, groupValue: $selected, title: Options.option2.rawValue)
        HStack(spacing: 0) {
          Spacer().frame(width: 100)
          TextField("", text: $quantity)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.horizontal, 10)
            .multilineTextAlignment(.trailing)
            .autoBorder(require: $fieldRequire, radius: 10, background: .white, fontSize: 18, weight: .medium)
            .disabled(selected != .option2)
        }
      }.frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(.colorBorder.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
      Spacer().frame(height: 25)
      HStack(spacing: 0) {
        Button("クリア") {
          selected = .option1
          from = Date()
          to = Date()
          quantity = ""
        }.buttonStyle(StyleButtonWithBackground(colorBG: .colorGrayBG, width: 100, minHeight: 50, radius: 30))
        Spacer()
        Button("検索") {
          router.to(Route.grantAppDetail)
        }.buttonStyle(StyleButtonWithBackground(colorBG: selected == .option2 && quantity.isEmpty ? .colorBorder : .colorBG2, width: 200, minHeight: 50, radius: 30)).disabled(selected == .option2 && quantity.isEmpty)
      }.padding(.horizontal, 20)
      Spacer().frame(height: 30)
      HStack {
        Color(uiColor: .colorBorder)
          .frame(maxWidth: .infinity)
          .frame(height: 1)
          .opacity(0.5)
      }.padding(.horizontal, 15)
      Spacer().frame(height: 20)
      Text("または").font(.system(size: 16, weight: .medium))
      Spacer().frame(height: 10)
      Button("クーポンを読み取って検索") {
          router.to(Route.couponScan)
      }.buttonStyle(StyleButtonWithBackground(colorBG: .colorBG2, width: 300, minHeight: 50, radius: 30, shadowOffsetY: 5))
    }.onAppear() {
      from = Date()
      to = Date()
    }.padding(.horizontal, 10)
  }
  
  @ViewBuilder
  private func radioButton<T: Hashable>(value: T, groupValue: Binding<T>, title: String) -> some View {
    HStack(spacing: 10) {
      Image(systemName: groupValue.wrappedValue == value ? "largecircle.fill.circle" : "circle")
        .imageScale(.large)
        .foregroundStyle(.colorLink)
      Text(title)
        .font(.system(size: 16, weight: .medium))
        .foregroundStyle(groupValue.wrappedValue == value ? .black.opacity(0.7) : .colorGrayBG.opacity(0.8))
    }
    .contentShape(Rectangle())
    .fixedSize()
    .onTapGesture {
      groupValue.wrappedValue = value
    }
  }
}

private enum Options: String, CaseIterable, Hashable {
  case option1 = "集計日", option2 = "クーポン番号"
}

#Preview {
  AdvancedSearchView()
}
