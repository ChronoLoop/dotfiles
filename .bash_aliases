alias vim=nvim
alias python=python3

alias jumpNvimconfig="cd  $HOME/.config/nvim"
alias jumpWindowsUsers="cd /mnt/c/Users/kevin"
alias sourcetmux='tmux source ~/.tmux.conf'
alias dotconf='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias vimdot='GIT_DIR=$HOME/dotfiles/ GIT_WORK_TREE=$HOME vim $HOME'
alias vimconf='GIT_DIR=$HOME/dotfiles/ GIT_WORK_TREE=$HOME vim $HOME/.config/nvim'

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
