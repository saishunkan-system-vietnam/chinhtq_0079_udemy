import SwiftUI
import UIKit

struct UnFocusTextField: UIViewRepresentable {
  
  func makeUIView(context: Context) -> UIView {
    let v = UIView()
    v.isUserInteractionEnabled = false
    DispatchQueue.main.async { [weak v] in
      if let w = v?.window { context.coordinator.attach(to: w) }
    }
    return v
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    if let w = uiView.window { context.coordinator.attach(to: w) }
  }
  
  func makeCoordinator() -> Coordinator { Coordinator() }

  final class Coordinator: NSObject, UIGestureRecognizerDelegate {
    private let tap = UITapGestureRecognizer()
    private weak var host: UIView?

    override init() {
      super.init()
      tap.addTarget(self, action: #selector(handle))
      tap.cancelsTouchesInView = false
      tap.delegate = self
    }
    
    func attach(to view: UIView) {
      guard host !== view else { return }
      host?.removeGestureRecognizer(tap)
      view.addGestureRecognizer(tap)
      host = view
    }
    
    @objc func handle() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil, from: nil, for: nil)
    }
    
    func gestureRecognizer(_ gr: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
      var v: UIView? = touch.view
      while let cur = v {
        if cur is UITextField || cur is UITextView || cur is UIControl { return false }
        v = cur.superview
      }
      return true
    }
    
    func gestureRecognizer(_ g: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith other: UIGestureRecognizer) -> Bool { true }
  }
}


