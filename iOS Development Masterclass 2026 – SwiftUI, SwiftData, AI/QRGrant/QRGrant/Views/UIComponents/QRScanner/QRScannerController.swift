import SwiftUI
import VisionKit

@MainActor
public final class QRScannerController: ObservableObject {
  fileprivate weak var uiVC: DataScannerViewController?
  var desiredActive = false

  public func start() {
    desiredActive = true
//    applyDesiredState()
  }

  public func stop() {
    desiredActive = false
//    applyDesiredState()
  }

  func attach(_ vc: DataScannerViewController) {
    uiVC = vc
    applyDesiredState()
  }

  func detach() { uiVC = nil }

  private func applyDesiredState() {
    guard let vc = uiVC,
          DataScannerViewController.isSupported,
          DataScannerViewController.isAvailable else { return }

    if desiredActive {
      print("start")
      if !vc.isScanning { try? vc.startScanning() }
    } else {
      if vc.isScanning  { vc.stopScanning()  }
    }
  }
}

