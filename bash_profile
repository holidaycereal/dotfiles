# .bash_profile

# get the aliases and functions
[ -f $HOME/.bashrc ] && source $HOME/.bashrc

prependpath $HOME/.local/bin
prependpath $HOME/.dotnet
prependpath $HOME/.dotnet/tools
prependpath $HOME/dev/wezterm/target/release

export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export QT_QPA_PLATFORM=wayland-egl
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export XCURSOR_SIZE=28
export QT_QPA_PLATFORMTHEME=qt6ct
export GRIM_DEFAULT_DIR="$HOME/av/images/ss"
export TERMINAL="/usr/bin/foot"
export DOTNET_ROOT="$HOME/.dotnet"
export GOPATH="$HOME/.go"

# rust environment
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# deno environment
. "$HOME/.deno/env"

# run wayland compositors depending on tty
case "$(tty)" in
    "/dev/tty1") exec dbus-run-session labwc ;;
    "/dev/tty2") exec dbus-run-session sway ;;
    *) true ;;
esac
