import SwiftUI

struct InforTodayView: View {
  @EnvironmentObject var router: AppRouter
  
    var body: some View {
      VStack {
        Spacer().frame(height: 20)
        Text("2023年03月01日").font(.system(size: 16, weight: .medium))
        Spacer().frame(height: 20)
        ZStack {
          HStack(spacing: 0) {
            VStack {
              Text(richText(value: "3枚"))
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
              .overlay(alignment: .topLeading) {
                Text("申請枚数").font(.system(size: 16, weight: .medium)).padding(.leading, 13).padding(.top, 13)
              }
            Color(uiColor: .colorBorder).frame(maxHeight: .infinity).frame(width: 1.5)
            VStack {
              Text(richText(value: "4,000円"))
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
              .overlay(alignment: .topLeading) {
                Text("申請額").font(.system(size: 16, weight: .medium)).padding(.leading, 13).padding(.top, 13)
              }
          }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.colorBorder, lineWidth: 1.7)
            )
        }.frame(maxWidth: .infinity)
          .frame(height: 220)
          .padding(.horizontal, 15)
          .padding(.vertical, 20)
          .background(.colorBorder.opacity(0.3))
          .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        Spacer().frame(height: 40)
        Button("詳細へ") {
          router.to(Route.grantAppDetail)
        }.buttonStyle(StyleButtonWithBackground(colorBG: .colorBG2, width: 150, minHeight: 50, radius: 30))
       }.padding(.horizontal, 10)
    }
  
  func richText(value: String) -> AttributedString {
      var s = AttributedString(value)
      s.font = .system(size: 16)
      s.foregroundColor = .colorLink
    
    if let r1 = (s.range(of: "3") ?? s.range(of: "4,000")) {
        s[r1].font = .system(size: 40, weight: .medium)
      }
      return s
    }
}

#Preview {
    InforTodayView()
}
