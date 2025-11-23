import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    NSLog("🚀 MainFlutterWindow.awakeFromNib")
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    NSLog("🔧 Calling RegisterGeneratedPlugins")
    RegisterGeneratedPlugins(registry: flutterViewController)
    NSLog("✅ RegisterGeneratedPlugins completed")

    super.awakeFromNib()
  }
}
