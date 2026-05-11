# Ubuntu Terminal Reproduction

This is the closest terminal-only Ubuntu setup based on the repo's non-GUI path. It mirrors the shell, CLI tools, Git defaults, and workflow aliases from the NixOS config, but uses normal Ubuntu package installs and dotfiles instead of Nix.

## 1. Install base packages

```bash
sudo apt update
sudo apt install -y zsh git curl wget unzip unrar build-essential pkg-config gcc make python3 python3-pip python3-venv ripgrep fd-find fzf zoxide tree btop fastfetch lshw mtr-tiny gnupg bat eza zsh-syntax-highlighting zsh-autosuggestions fd-find fzf zoxide btop fastfetch
```

Notes:

- On Ubuntu, `fd-find` provides `fd`.
- On Ubuntu, `bat` is often exposed as `batcat`.
- `eza` may be available from the Ubuntu archive or via a third-party package source on older releases.

## 2. Make zsh the default shell

```bash
sudo chsh -s "$(command -v zsh)" "$USER"
```

Log out and back in after this.

## 3. Install mise

```bash
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
```

If you prefer a cleaner layout, move the activation line into a separate file and source it from `~/.zshrc`.

## 4. Install Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
```

If you want the same prompt feel as the repo, copy your existing `.p10k.zsh` into `~/.p10k.zsh` and source it from `~/.zshrc`.

## 5. Create a minimal `~/.zshrc`

```bash
cat > ~/.zshrc <<'EOF'
# ---------------------------------
# Environment
# ---------------------------------

export EDITOR=vim

# ---------------------------------
# Theme
# ---------------------------------

source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# mise (PATH/env setup early)
eval "$(~/.local/bin/mise activate zsh)"

# ---------------------------------
# Completion system
# ---------------------------------

autoload -Uz compinit
# Only regenerate .zcompdump once a day or if it's missing
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# ---------------------------------
# CLI aliases
# ---------------------------------

alias ls='eza'
alias bat='batcat'
alias lg='lazygit'

alias gs='git status'
alias gadd='git add .'
alias gdc='git diff --cached'
alias gdom='git diff origin/main'
alias glog='git log --oneline'
alias gc='git commit -m'
alias gca='git commit -am'
alias gcam='git commit --amend'
alias gp='git push'

alias pn='pnpm'
alias pi='pnpm install'
alias padd='pnpm add'

alias doco='docker compose'
`
# ---------------------------------
# Plugins
# ---------------------------------

# autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting (must be last)
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---------------------------------
# Keybinds
# ---------------------------------

bindkey "${terminfo[kLFT5]}" backward-word
bindkey "${terminfo[kRIT5]}" forward-word
EOF
```

## 6. Install the remaining CLI tools

```bash
sudo apt install -y lazygit
```

For tools that are not in the Ubuntu archive, install them with the package manager you already use:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://deno.land/install.sh | sh
curl -fsSL https://bun.sh/install | bash
```

## 7. Optional developer tools

These match the repo's extra CLI workflow well if you need them:

```bash
sudo apt install -y docker.io docker-compose-plugin
python3 -m pip install --user git+https://github.com/nektos/act.git
```

## 8. Quick verification

```bash
zsh --version
git --version
rg --version
fdfind --version
fzf --version
zoxide --version
btop
fastfetch
```

## Result

After this, Ubuntu should feel close to the repo's terminal-only setup:

- zsh as the login shell
- Powerlevel10k prompt
- mise for toolchain activation
- eza, batcat, lazygit, ripgrep, fd, fzf, zoxide, tree, diff-so-fancy
- a vim-first, CLI-only workflow with no GUI apps required

## GIT CONFIG

```bash
git config --global user.email "twój_email@example.com"
git config --global user.name "NAME NAME"
ssh-keygen -t ed25519 -C "twój_email@example.com"
```
