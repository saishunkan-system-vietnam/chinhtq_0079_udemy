import SwiftUI

struct StyleButtonWithBackground: ButtonStyle {
  var colorBG: Color?
  var textColor: Color?
  var width: CGFloat?
  var height: CGFloat?
  var minHeight: CGFloat?
  var radius: CGFloat?
  var shadowOffsetY: CGFloat?
  var fontSize: CGFloat?
  var fontWeight: Font.Weight?
  var paddingH: CGFloat?
  var iconLeading: String?
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: fontSize ?? 16, weight: fontWeight ?? .bold))
      .frame(maxWidth: width ?? .infinity, maxHeight: height ?? 50)
      .frame(minHeight: minHeight)
      .padding(.horizontal, paddingH ?? 0)
      .background(colorBG ?? .colorPrimary)
      .foregroundColor(textColor ?? .white)
      .clipShape(RoundedRectangle(cornerRadius: radius ?? 10, style: .continuous))
      .opacity(configuration.isPressed ? 0.7 : 1)
      .shadow(color: .black.opacity(configuration.isPressed ? 0.12 : 0.25),
              radius: configuration.isPressed ? 4 : 10,
              x: 0,
              y: configuration.isPressed ? 2 : (shadowOffsetY ?? 0))
      .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
      .overlay(alignment: .leading) {
        if iconLeading != nil {
          HStack {
            Spacer().frame(width: 20)
            Image(iconLeading!)
          }
        }
      }
  }
}
