# Reset Dictation

A lightweight macOS menu bar app that kills the `DictationIM` process with a single click. Useful when macOS dictation gets stuck or unresponsive.

## Features

- Lives in the menu bar as a 🎤 icon
- **Left-click** the icon to instantly run `killall DictationIM` and see a brief confirmation toast
- **Right-click** the icon for a menu with Quit
- No Dock icon — runs as a background accessory app

## Install

### Option 1: Download the Release (recommended)

1. Go to [Releases](https://github.com/scrappydog/osx-reset-dictation/releases/latest)
2. Download `ResetDictation.zip`
3. Unzip and drag `ResetDictation.app` to your Applications folder (or `~/Applications`)
4. Launch the app — you'll see a 🎤 in your menu bar

> **Note:** On first launch, macOS may block the app because it's unsigned. Go to **System Settings → Privacy & Security** and click **Open Anyway**.

### Option 2: Build from Source

Requires Xcode Command Line Tools (`xcode-select --install`).

```bash
git clone https://github.com/scrappydog/osx-reset-dictation.git
cd osx-reset-dictation
make install
open ~/Applications/ResetDictation.app
```

## Usage

| Action | Result |
|--------|--------|
| Left-click 🎤 | Kills `DictationIM` and shows a confirmation toast |
| Right-click 🎤 | Opens menu with Quit option |

## Start at Login

To launch automatically on login, add `ResetDictation.app` in **System Settings → General → Login Items**.

## Uninstall

```bash
make uninstall
```

Or manually delete `ResetDictation.app` from your Applications folder and remove it from Login Items.

## License

[MIT](LICENSE)
