```bash
git clone --bare https://github.com/ChronoLoop/dotfiles.git $HOME/dotfiles
```

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
