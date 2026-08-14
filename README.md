# Windows 11 Tokyo Night Storm Dotfiles

A complete Windows 11 desktop customization (rice) themed around the Storm variant of the popular Tokyo Night color palette.

---

## Dependencies and Requirements

The following core applications are required for this setup to function properly:

### Core Apps
* **Windows Terminal** – Used as the primary terminal emulator.
* **Windows PowerShell** – Used as the default shell.
* **GlazeWM** – Used for tiling window management.
* **[YASB (Yet Another Status Bar)](https://yasb.dev/)** – Used for the desktop status bar.
* **Nilesoft Shell** – Used for the customized context menu.
* **Fastfetch & Winfetch** – Used to display system statistics aesthetically.

### Recommended Apps (For a unified theme/Terminal applications)
* **Firefox**
* **Discord**
* **VSCodium**
* **Sublime Text**
* **Spotify + Spicetify**
* **clock-rs**
* **pipes-rs**
* **rbonsai**
* **rs-matrix**
* **btm**
* **btop4win**

> **Important:** Download the recommended applications directly from their official websites. Avoid using the Microsoft Store, as store-packaged apps can restrict custom theming.

---

## Important Configuration for Wallpapers

Before launching YASB, you must update a file path to match your wallpaper directory:

1. Open the **YASB** configuration file (`config.yaml`).
2. Navigate to **line 475**.
3. Change the path so the **wallpaper switcher** points to your correct local wallpaper directory.

---

## Keybinds

This setup introduces custom shortcuts alongside the default GlazeWM keybindings.

| Keybind | Action |
| :--- | :--- |
| <kbd>Alt</kbd> + <kbd>Q</kbd> | Close active application |
| <kbd>Alt</kbd> + <kbd>S</kbd> | Launch Terminal |
| <kbd>Alt</kbd> + <kbd>W</kbd> | Open wallpaper switcher |
| <kbd>Alt</kbd> + <kbd>C</kbd> | Open app launcher |
| <kbd>Alt</kbd> + <kbd>Y</kbd> | Open shutdown menu |

*Note: Any keybinds not listed above follow the default configuration of **GlazeWM**.*
