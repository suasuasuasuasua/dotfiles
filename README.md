# dotfiles

My small dotfiles collection for development. I generally use OS like Debian and
Ubuntu with KDE. **Currently trying out Arch Linux with Sway WM.**

## Desktop Environment

- kde plasma (traditional DE when I'm lazy)

## Window Management

- sway (tiling window manager -- loving it so far!)
- waybar (wayland status bar)
- ly (display manager)
- fuzzel (application launcher)

### Support

- `mako` (wayland notification daemon)
- `slurp` (wayland region selector)
- `swayidle` (wayland idle daemon)
- `swaylock` (wayland lockscreen daemon)
- `pamixer` (pulse audio volume mixer)
- `wob` (wayland overlay bar)
- `libinput-gestures` (support trackpad gestures)

### Fonts and Themes

- JetBrains Mono (goated monospace font)
- Poppins (general font frmo Google)
- Baekmuk (collection of Korean fonts because I'm a koreaboo)
- Font Awesome (for glyphs and things)
- Catppuccin Mocha Lavender (goated pastel theme)

## General

- Firefox (web browser)
  - vimium (vim-like navigation)
  - adguard (hide the ads and block the trackers)
- Spotify (music player)
  - Spicetify (*spiced* up)
- Discord (socializing app)
- Thunderbird (email client)
- Zathura (document browser)
  - Install `zathura-pdf-mupdf` to view PDFs

### Computer Management

- Nemo (GUI file browser)
- Filelight (disk examiner)
- Pulse Audio Volume Control (volume controller)
- Timeshift (backup manager)
- NetworkManager (network management daemon)
  - `nmcli` and `nmtui`

### CLI

- `zsh` (shell)
  - oh my zsh (pimp out the zsh prompts and functionality)
- `fastfetch` (system information rundown)
- `btop` (tui system monitor)
- `yazi` (TUI file browser)
- `imv` (mage viewer)
- `mpv` (media player)
- `wf-recorder` (tui screen recorder)
  - `pipewire` and `gst-plugin-pipewire` as dependencies
- `wiki-tui` (wikipedia text user interface)
- `diff-so-fancy` (pretty `git` diffs)

## Development

- `tmux` (terminal multiplexer)
- virt-manager (virtual machine manager)
- docker engine (containerization)
- `glow` (markdown notes management)
- `soft-serve` (self hosted git server)

### Terminal Emulators

- alacritty (fast and has copy mode but doesn't support CLI image viewing)
- kitty (fast and supports CLI image viewing but doesn't have copy mode)
- foot (lightweight but doesn't have copy mode)

### Text Editors

- `vim`
  - using VimPlug as the package manager
  - see the `.vimrc` for a list of relatively minimal extensions
- `nvim` (trying to migrate!)
  - `tree-sitter-cli` (an important dependency for syntax highlighting)
  - using `lazy.nvim` as the package manager and mason as the LSP manager
  - also a bunch of other extensions defined in [kickstart.git](https://www.github.com/suasuasuasuasua/nvim)
- vscode (goated text editor turned IDE)
- zed (trying as an alternative!)
