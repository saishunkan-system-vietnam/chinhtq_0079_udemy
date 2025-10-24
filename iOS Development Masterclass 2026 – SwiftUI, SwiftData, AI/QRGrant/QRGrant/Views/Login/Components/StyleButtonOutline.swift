import SwiftUI

struct StyleButtonOutline: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 16))
      .frame(maxWidth: .infinity)
      .padding(.vertical, 25)
      .padding(.horizontal, 20)
      .foregroundColor(.colorPrimary)
      .multilineTextAlignment(.center)
      .background(
        RoundedRectangle(cornerRadius: 12).fill(.white)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .strokeBorder(.colorPrimary, lineWidth: 1.7)
      )
      .opacity(configuration.isPressed ? 0.7 : 1)
  }
}
