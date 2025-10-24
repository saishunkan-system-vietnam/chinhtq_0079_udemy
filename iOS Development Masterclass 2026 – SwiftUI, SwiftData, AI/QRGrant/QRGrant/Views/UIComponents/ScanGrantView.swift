import SwiftUI

struct ScanGrantView: View {
  var mainColor: Color
  var title1: String
  var title2: String
  var title3: String?
  var buttonTitle: String
  var appbarTitle: String
  var onComplete: ([String]) -> Void
  
  @State private var values: [String] = []
  @StateObject private var controllerSC = QRScannerController()
  @EnvironmentObject private var appbarState: AppbarState
  @EnvironmentObject var router: AppRouter
  @Environment(\.screenSize) private var size
  
    var body: some View {
      ScrollView {
        LazyVStack(spacing: 0) {
          Spacer().frame(height: 40)
          Text(title1)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(mainColor)
          Text(title2)
            .font(.system(size: title3 != nil ? 17 : 14,
                          weight: title3 != nil ? .bold : .regular))
            .multilineTextAlignment(.center)
            .foregroundStyle(title3 != nil ? .colorPrimary : .black.opacity(0.7))
          if title3 != nil {
            Text(title3!)
              .font(.system(size: 14))
              .multilineTextAlignment(.center)
          }
          Spacer().frame(height: 20)
          QRScannerView(controller: controllerSC) { value in
            print("scanner[\(value)]")
            if !values.contains(value) {
              values.append(value)
            }
          }.frame(height: size.height * 0.5)
            .onAppear {
              print("onAppear")
              controllerSC.start()
            }
            .onDisappear { 
              controllerSC.stop()
              controllerSC.detach()
            }
          Spacer().frame(height: 15)
          HStack {
            Text("0")
              .font(.system(size: 60, weight: .medium))
              .foregroundStyle(.colorLink)
            Text("枚").frame(height: 49, alignment: .bottom)
          }
          Spacer().frame(height: 50)
          Button (buttonTitle) {
            onComplete(values)
          }.buttonStyle(StyleButtonWithBackground(colorBG: mainColor, width: 200, minHeight: 50, radius: 30))
          Spacer().frame(height: 20)
        }
      }.scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .onAppear() {
        appbarState.title = appbarTitle
        appbarState.leading = nil
        appbarState.background = mainColor
        appbarState.isBack = true
        appbarState.onBack = {
          appbarState.background = .colorPrimary
          router.pop()
        }
      }.frame(maxHeight: .infinity, alignment: .top).appbar()
    }
}

#Preview {
  ScanGrantView(mainColor: .colorPrimary, title1: "地域クーポン", title2: "を読み取ってください\n※一度に読み取れるのは最大1,000枚です", buttonTitle: "確認画面へ", appbarTitle: "補助金申請") { values in print("\(values)")}
}
