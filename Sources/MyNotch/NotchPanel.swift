import AppKit
import SwiftUI

@MainActor
class NotchPanel: NSPanel {

    init(contentRect: NSRect) {
        super.init(
            contentRect: contentRect,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        configurePanelProperties()
        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configurePanelProperties() {
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .statusBar
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        self.isMovable = false
        self.hasShadow = false

        // Listen for screen resolution changes or display connects/disconnects
        NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.centerAtTop()
            }
        }
    }

    private func setupContentView() {
        let hostingView = NSHostingView(rootView: NotchContainerView())
        self.contentView = hostingView
    }

    func centerAtTop(of targetScreen: NSScreen? = NSScreen.main) {
            guard let screen = targetScreen else { return }

            let screenFrame = screen.frame
            let panelSize = self.frame.size

            // Check if display has a physical hardware notch
            let hasNotch = screen.safeAreaInsets.top > 0

            // Calculate X to center horizontally on screen
            let xPos = screenFrame.origin.x + (screenFrame.width - panelSize.width) / 2

            // Calculate Y to pin to top edge of the screen
            let yPos = screenFrame.origin.y + screenFrame.height - panelSize.height

            let targetFrame = NSRect(
                x: xPos,
                y: yPos,
                width: panelSize.width,
                height: panelSize.height
            )

            // Apply position without animation for initial placement
            self.setFrame(targetFrame, display: true)

            print("Anchored to screen: \(screen.localizedName), Has Notch: \(hasNotch)")
        }
}
