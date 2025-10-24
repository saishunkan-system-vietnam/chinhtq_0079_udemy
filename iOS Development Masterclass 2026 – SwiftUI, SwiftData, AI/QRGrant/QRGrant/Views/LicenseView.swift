import SwiftUI

struct LicenseView: View {
  @EnvironmentObject var appbarState: AppbarState
  
  var body: some View {
    VStack {
      
    }.onAppear() {
      appbarState.title = "ライセンス"
      appbarState.leading = nil
    }.frame(maxHeight: .infinity).appbar()
  }
}

#Preview {
  LicenseView()
}
