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

Add to VSCode's settings.json:
```json
// leaves out c, f and k (and the arrow/backspace/delete combos) so VSCode keeps those shortcuts
"vscode-neovim.ctrlKeysForNormalMode": [
    "a", "b", "d", "e", "h", "i", "j", "l", "m", "o", "r", "t", "u", "v", "w", "x", "y", "z", "/", "]"
],
// only if VSCode can't find nvim on its own
"vscode-neovim.neovimExecutablePaths.linux": "/path/to/nvim"

// optional: runs vscode-neovim in its own thread so other extensions can't slow it down
"extensions.experimental.affinity": {
    "asvetliakov.vscode-neovim": 1
},
```