## Linux

```bash
git clone --bare https://github.com/ChronoLoop/dotfiles.git $HOME/dotfiles
```

```bash
git --git-dir=$HOME/dotfiles --work-tree=$HOME checkout
```

```bash
source $HOME/.bash_aliases
```

```bash
dotconf config --local status.showUntrackedFiles no
```

```bash
dotconf config --local core.worktree $HOME
```

## PowerShell

```bash
git clone https://github.com/ChronoLoop/dotfiles.git $HOME/dotfiles
```

```bash
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', "$HOME\dotfiles\.config", "User")
```
