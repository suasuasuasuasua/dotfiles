# Firefox wayland:
export MOZ_ENABLE_WAYLAND=1

# ~/.config/environment.d/30-electron-ozone-wayland.conf
export ELECTRON_OZONE_PLATFORM_HINT=auto
export GTK_BACKEND=wayland

# Rust environemnt stuff
. "$HOME/.cargo/env"