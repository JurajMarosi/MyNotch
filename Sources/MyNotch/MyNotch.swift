import AppKit

@main
@MainActor
class AppDelegate: NSObject, NSApplicationDelegate {

    var panel: NotchPanel?

    static func main() {
        let app = NSApplication.shared
        let delegate = AppDelegate()
        app.delegate = delegate
        app.setActivationPolicy(.accessory)
        app.run()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Position panel at top center (Test frame: width 300, height 150)
        let panelSize = NSSize(width: 300, height: 120)
        let initialRect = NSRect(origin: .zero, size: panelSize)

        self.panel = NotchPanel(contentRect: initialRect)
        self.panel?.centerAtTop() // Dynamically anchors under the physical notch
        self.panel?.orderFrontRegardless()

        print("NotchPanel initialized and ordered front.")
    }
}
