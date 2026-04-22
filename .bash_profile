# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

. "$HOME/.cargo/env"

#GO paths
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

LS_COLORS=$LS_COLORS:'ow=1;34:'
export LS_COLORS

export GIT_EDITOR=vim

#Dotnet paths
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

# Yazi
export EDITOR=nvim
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

#Zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# Latex
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH

# Android
if [ -d "$HOME/android" ]; then
    export ANDROID_SDK_ROOT=$HOME/android/

    if [ -d "$ANDROID_SDK_ROOT/platform-tools" ]; then
        export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
    fi

    if [ -d "$ANDROID_SDK_ROOT/cmdline-tools/bin" ]; then
        export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin
    fi
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
