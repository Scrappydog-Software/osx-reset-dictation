import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var toastWindow: NSWindow?
    var dismissTimer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.button?.title = "🎤"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(statusItemClicked(_:))
        statusItem.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }

    @objc func statusItemClicked(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        if event.type == .rightMouseUp {
            let menu = NSMenu()
            menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
            statusItem.menu = nil
        } else {
            resetDictation()
        }
    }

    func resetDictation() {
        let task = Process()
        task.launchPath = "/usr/bin/killall"
        task.arguments = ["DictationIM"]
        try? task.run()
        showToast()
    }

    func showToast() {
        dismissTimer?.invalidate()
        dismissTimer = nil
        toastWindow?.orderOut(nil)
        toastWindow = nil

        guard let button = statusItem.button,
              let buttonWindow = button.window else { return }

        let buttonRect = buttonWindow.frame

        let padding: CGFloat = 16
        let height: CGFloat = 32
        let text = "Dictation Reset"

        let label = NSTextField(labelWithString: text)
        label.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .clear
        label.isBezeled = false
        label.isEditable = false
        label.sizeToFit()

        let width = label.frame.width + padding * 2
        let x = buttonRect.midX - width / 2
        let y = buttonRect.minY - height - 4

        let window = NSWindow(contentRect: NSRect(x: x, y: y, width: width, height: height),
                              styleMask: .borderless, backing: .buffered, defer: false)
        window.backgroundColor = NSColor.black.withAlphaComponent(0.8)
        window.isOpaque = false
        window.level = .statusBar
        window.hasShadow = true
        window.isReleasedWhenClosed = false

        let contentView = NSView(frame: NSRect(x: 0, y: 0, width: width, height: height))
        contentView.wantsLayer = true
        contentView.layer?.cornerRadius = 8
        contentView.layer?.masksToBounds = true
        contentView.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.8).cgColor
        window.contentView = contentView

        label.frame = NSRect(x: padding, y: (height - label.frame.height) / 2,
                             width: label.frame.width, height: label.frame.height)
        contentView.addSubview(label)

        window.orderFront(nil)
        toastWindow = window

        dismissTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] _ in
            self?.toastWindow?.orderOut(nil)
            self?.toastWindow = nil
            self?.dismissTimer = nil
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()
