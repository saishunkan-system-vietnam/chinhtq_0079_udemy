import SwiftUI

struct CouponScanView: View {
  @EnvironmentObject var router: AppRouter
  @EnvironmentObject var appbarState: AppbarState
  @StateObject private var controllerSC = QRScannerController()
  @State private var count: Int = 0
  
    var body: some View {
      ZStack {
        QRScannerView(controller: controllerSC) { value in
          count+=1
          if count == 1 {
            router.off(Route.grantAppDetail)
          }
        }.onAppear { controllerSC.start() }
         .onDisappear { controllerSC.stop() }
      }.onAppear() {
        appbarState.title = "クーポン読み取り"
      }.frame(maxHeight: .infinity).appbar()
    }
}

#Preview {
    CouponScanView()
}
