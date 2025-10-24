import SwiftUI

final class AppbarState: ObservableObject {
  struct Item: Identifiable {
    let id = UUID()
    let systemImage: String?
    let title: String?
    let action: () -> Void
  }
  
  @Published var background: Color = .colorPrimary
  @Published var title: String = ""
  @Published var isBack: Bool = true
  var onBack: (() -> Void)?
  
  @Published var trailing: [Item] = []
  @Published var leading: AnyView?
}

struct AppbarModifier: ViewModifier {
  @Environment(\.screenSize) private var size
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var bar: AppbarState
  
  func body(content: Content) -> some View {
    VStack(spacing: 0) {
      ZStack {
        bar.background
          .frame(maxWidth: .infinity)
          .ignoresSafeArea()
          .shadow(color: .black.opacity(0.25), radius: 5, y: 5)
        HStack {
          Group {
            if let viewLeading = bar.leading {
              viewLeading
            } else if bar.isBack {
              Button {
                (bar.onBack ?? { dismiss() })()
              } label: {
                Label("戻る", systemImage: "chevron.backward")
                  .labelStyle(.titleAndIcon)
                  .font(.system(size: 15))
                  .tint(.white)
                  .foregroundStyle(.white)
              }.buttonStyle(.borderless)
            }
          }
          Spacer()
        }.padding(.horizontal,14)
          .padding(.bottom,3)
          .overlay(alignment: .center) {
            VStack {
              Text(bar.title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
              Spacer().frame(height: 3)
            }
          }
      }.frame(height: 37).zIndex(1)
      content.zIndex(0)
    }.toolbar(.hidden, for: .navigationBar)
  }
}

extension View {
  func appbar() -> some View { modifier(AppbarModifier()) }
}
