import SwiftUI
import VisionKit

public struct QRScannerView: UIViewControllerRepresentable {
  var onCode: (String) -> Void
  
  @ObservedObject var controller: QRScannerController
  
  public init(controller: QRScannerController, onCode: @escaping (String) -> Void) {
    self.controller = controller
    self.onCode = onCode
  }
  
  public func makeUIViewController(context: Context) -> DataScannerViewController {
    let vc = DataScannerViewController(
      recognizedDataTypes: [.barcode(symbologies: [.qr])],
      qualityLevel: .balanced,
      recognizesMultipleItems: false,
      isHighFrameRateTrackingEnabled: true,
      isHighlightingEnabled: true
    )
    vc.view.backgroundColor = .black
    vc.delegate = context.coordinator
    controller.attach(vc)
    return vc
  }
  
  public func updateUIViewController(_ uiVC: DataScannerViewController, context: Context) {
    uiVC.view.backgroundColor = .black
    uiVC.delegate = context.coordinator
    controller.attach(uiVC)
//    if controller.desiredActive {
//      print("update view[\(controller.desiredActive)]")
//      try? uiVC.startScanning()
//    }
  }
  
  public static func dismantleUIViewController(
    _ uiVC: DataScannerViewController, coordinator: Coordinator
  ) {
    uiVC.stopScanning()
//    uiVC.delegate = nil
  }
  
  public func makeCoordinator() -> Coordinator { Coordinator(onCode: onCode) }
  
  final public class Coordinator: NSObject, DataScannerViewControllerDelegate {
    let onCode: (String) -> Void
    init(onCode: @escaping (String) -> Void) { self.onCode = onCode }
    
    public func dataScanner(_ dataScanner: DataScannerViewController,
                     didAdd addedItems: [RecognizedItem],
                     allItems: [RecognizedItem]) {
      for item in addedItems {
        if case let .barcode(payload) = item,
           let value = payload.payloadStringValue {
          onCode(value)
          break
        }
      }
    }
  }
}
