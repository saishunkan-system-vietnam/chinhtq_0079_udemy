import SwiftUI

struct OutlineTextField: ViewModifier {
  @FocusState private var isFocused: Bool
  
  @Binding var require: String
  var radius: CGFloat
  var background: Color
  var fontSize: CGFloat
  var weight: Font.Weight
  
  func body(content: Content) -> some View {
    VStack(alignment: .leading) {
      content
        .focused($isFocused)
        .font(.system(size: fontSize, weight: weight))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .background(
          RoundedRectangle(cornerRadius: radius).fill(background)
        )
        .overlay(
          RoundedRectangle(cornerRadius: radius)
            .strokeBorder(isFocused ? .colorFocus : .colorBorder, lineWidth: 1.7)
        )
        .animation(.easeInOut(duration: 0.1), value: isFocused)
      if !require.isEmpty {
        HStack {
          Spacer().frame(width: 20)
          Text(require)
            .font(.system(size: 12))
            .foregroundStyle(.red.opacity(0.8))
        }
      }
    }
  }
}

extension View {
  func autoBorder(require: Binding<String>, radius: CGFloat = 30, background: Color = .colorGreyBG, fontSize: CGFloat = 14, weight: Font.Weight = .regular) -> some View {
    modifier(OutlineTextField(require: require, radius: radius, background: background, fontSize: fontSize, weight: weight))
  }
}
