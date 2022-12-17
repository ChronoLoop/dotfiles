alias vim=nvim
alias python=python3

alias jumpNvimconfig="cd  $HOME/.config/nvim"
alias jumpWindowsUsers="cd /mnt/c/Users/kw_pc"
alias sourcetmux='tmux source ~/.tmux.conf'
alias dotconf='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dotvim='GIT_DIR=$HOME/dotfiles/ GIT_WORK_TREE=$HOME vim $HOME'

#GO paths
export PATH=$PATH:/usr/local/go/bin

LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS
