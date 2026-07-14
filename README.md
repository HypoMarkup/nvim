### Nvim config
one of the configs of all time

#### For when apt is being apt

```
# Latest self-updating rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

#  (installer also writes this into ~/.bashrc for new shells)
. "$HOME/.cargo/env"

cargo install --locked tree-sitter-cli
cargo install --locked ripgrep

# fzf is Go
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
```

#### Other things to do

Make capslock esc (and shift capslock lock caps) by adding this to bashrc
```
[ -n "$DISPLAY" ] && setxkbmap -option caps:escape_shifted_capslock
```

Install a nerd font

Gnome terminal freaks out with spacing when u change font without closing ALL terminals and opening a fresh one
