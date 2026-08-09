# ---------------------------------
# Instant prompt
# ---------------------------------

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# Word-jump keybinds
# ---------------------------------

bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward

[[ -n ${terminfo[kLFT5]} ]] && bindkey "${terminfo[kLFT5]}" backward-word
[[ -n ${terminfo[kRIT5]} ]] && bindkey "${terminfo[kRIT5]}" forward-word

# fallback if terminfo doesn't have them
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# ---------------------------------
# History
# ---------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Share history across sessions immediately
setopt SHARE_HISTORY # Automatically imports/exports commands in real time
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded
setopt HIST_FIND_NO_DUPS # Do not display duplicates when searching history
setopt HIST_IGNORE_SPACE # Don't record commands starting with a space
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording
setopt EXTENDED_HISTORY        # save timestamp + duration, needed for HIST_EXPIRE_DUPS_FIRST
setopt HIST_EXPIRE_DUPS_FIRST  # when trimming to SAVEHIST, drop dup entries before unique ones

# ---------------------------------
# CLI aliases
# ---------------------------------

alias ls='eza'
alias bat='batcat'
alias lg='lazygit'

alias gs='git status'
alias gadd='git add -A'
alias gdc='git diff --cached'
alias gdom='git diff origin/main'
alias gdiff='git diff'
alias glog='git log --oneline'
alias gc='git commit -m'
alias gca='git commit -am'
alias gcam='git commit --amend'
alias gp='git push'

alias pn='pnpm'
alias pi='pnpm install'
alias padd='pnpm add'

alias doco='docker compose'

alias shadcn='pnpm dlx shadcn@latest'

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