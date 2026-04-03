# Reset Dictation

A lightweight macOS menu bar app that kills the `DictationIM` process with a single click. Useful when macOS dictation gets stuck or unresponsive.

## Features

- Lives in the menu bar as a 🎤 icon
- **Left-click** the icon to instantly run `killall DictationIM` and see a brief confirmation toast
- **Right-click** the icon for a menu with Quit
- No Dock icon — runs as a background accessory app

## Requirements

- macOS with Xcode Command Line Tools (`xcode-select --install`)

## Build & Install

```bash
# Compile
swiftc ResetDictation.swift -o ResetDictation

# Create app bundle
mkdir -p ~/Applications/ResetDictation.app/Contents/MacOS
cp ResetDictation ~/Applications/ResetDictation.app/Contents/MacOS/
cp Info.plist ~/Applications/ResetDictation.app/Contents/

# Launch
open ~/Applications/ResetDictation.app
```

## Start at Login

Add `~/Applications/ResetDictation.app` in **System Settings → General → Login Items** to launch automatically on login.

## License

MIT
