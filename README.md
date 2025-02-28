## Linux

```bash
git clone --bare https://github.com/ChronoLoop/dotfiles.git $HOME/dotfiles
```

You may need to copy .gitignore to $HOME before the next step:

```bash
git checkout --git-dir=$HOME/dotfiles --work-tree=$HOME
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
