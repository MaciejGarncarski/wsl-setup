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