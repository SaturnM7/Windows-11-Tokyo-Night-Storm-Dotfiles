<img width="1919" height="1079" alt="grafik" src="https://github.com/user-attachments/assets/6147b0a8-e9ca-4579-a4c3-d2b8b60b0d8e" />
<img width="1919" height="1079" alt="grafik" src="https://github.com/user-attachments/assets/26d527dc-9519-441d-b829-c41ef3fb46d1" />


# Windows 11 Tokyo Night Storm Dotfiles
```text
████████╗████████╗██╗   ██╗
╚══██╔══╝╚══██╔══╝╚██╗ ██╔╝
   ██║      ██║    ╚████╔╝ 
   ██║      ██║     ╚██╔╝  
   ██║      ██║      ██║   
   ╚═╝      ╚═╝      ╚═╝                         
```
A complete Windows 11 desktop customization (rice) themed around the Storm variant of the popular Tokyo Night color palette.

---

## Dependencies and Requirements

The following core applications are required for this setup to function properly:

### Core Apps
* **Windows Terminal** – Used as the primary terminal emulator.
* **Windows PowerShell** – Used as the default shell.
* **[GlazeWM](https://github.com/glzr-io/glazewm)** – Used for tiling window management.
* **[YASB (Yet Another Status Bar)](https://yasb.dev/)** – Used for the desktop status bar.
* **[Nilesoft Shell](https://nilesoft.org/)** – Used for the customized context menu.
* **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** – Used to display system statistics aesthetically.
* **[Starship Prompt](https://starship.rs/)** - A minimal and fast cross-platform Terminal Prompt.

### Recommended Apps (For a unified theme/Other useful Tools)
* **[Discord](https://discord.com/) + [Vencord](https://vencord.dev/)**
* **[VSCodium](https://vscodium.com/)**
* **[Sublime Text](https://www.sublimetext.com/) (alternative to VSCodium)**
* **[Spotify](https://open.spotify.com/) + [Spicetify](https://spicetify.app/)**
* **[clock-rs](https://github.com/Oughie/clock-rs)**
* **[pipes-rs](https://github.com/lhvy/pipes-rs)**
* **[rbonsai](https://github.com/roberte777/rbonsai)**
* **[rs-matrix](https://github.com/TitaniumBrain/rs-matrix)**
* **[btm](https://github.com/clementtsang/bottom)**
* **[btop4win](https://github.com/aristocratos/btop4win)**
* **[cava](https://github.com/karlstav/cava)**
* **[Winfetch](https://github.com/lptstr/winfetch)**

> **Important:** Download the recommended applications directly from their official websites or via a package manager such as winget or scoop. Avoid using the Microsoft Store, as store-packaged apps can restrict custom theming (e.g. Spotify).

---

## Important Configuration Steps
Before using Firefox, YASB, Fastfetch and Winfetch you must update the file paths to match your correct directories and/or make a few preparations:

**Firefox**
1. Type `about:config` in your Firefox searchbar.
2. search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set it to `true`.
3. Paste `FirefoxColor@mozilla.com.xpi` into your Firefox profiles extensions folder.
4. Clone this repository and paste the entire `chrome` folder into your Firefox profile directory.
5. Open firefox and install the Firefox color Extension by Firefox.
6. Activate vertical tabs.

**YASB**
1. Open the **YASB** configuration file (`config.yaml`).
2. Navigate to **line 475**.
3. Change the path so the **wallpaper switcher** points to your correct local wallpaper directory.

**Fastfetch**
1. Open the configuration file (`config.jsonc`).
2. Change the file path to your desired `ascii.txt`.

**Winfetch**
1. Open the configuration file (`config.ps1`).
2. Change the file path to your desired `image.png`.
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
