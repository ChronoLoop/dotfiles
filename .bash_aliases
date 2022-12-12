alias vim=nvim
alias python=python3

alias jumpNvimconfig="cd  $HOME/.config/nvim"
alias jumpWindowsUsers="cd /mnt/c/Users/kw_pc"
alias sourcetmux='tmux source ~/.tmux.conf'
alias dotconfig='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

#GO paths
export PATH=$PATH:/usr/local/go/bin

# Open tab in same directory (wsl)
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS