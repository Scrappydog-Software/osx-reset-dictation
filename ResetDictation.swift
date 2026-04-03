import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var toastWindow: NSWindow?

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
        toastWindow?.close()

        guard let button = statusItem.button,
              let buttonWindow = button.window else { return }

        let buttonRect = buttonWindow.frame
        let label = NSTextField(labelWithString: "Dictation Reset")
        label.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.sizeToFit()

        let padding: CGFloat = 16
        let width = label.frame.width + padding * 2
        let height: CGFloat = 32
        let x = buttonRect.midX - width / 2
        let y = buttonRect.minY - height - 4

        let window = NSWindow(contentRect: NSRect(x: x, y: y, width: width, height: height),
                              styleMask: .borderless, backing: .buffered, defer: false)
        window.backgroundColor = .clear
        window.isOpaque = false
        window.level = .statusBar

        let view = NSVisualEffectView(frame: window.contentView!.bounds)
        view.material = .hudWindow
        view.state = .active
        view.wantsLayer = true
        view.layer?.cornerRadius = 8
        view.layer?.masksToBounds = true
        window.contentView = view

        label.frame = NSRect(x: padding, y: (height - label.frame.height) / 2, width: label.frame.width, height: label.frame.height)
        view.addSubview(label)

        window.orderFront(nil)
        toastWindow = window

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.toastWindow?.close()
            self?.toastWindow = nil
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()
