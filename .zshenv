#!/bin/zsh

pathadd() {
  [[ -d "$1" ]] && PATH="$1${PATH:+":$PATH"}"
}

pathadd "/usr/local/bin"
pathadd "/usr/local/sbin"
pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/.fzf/bin"
pathadd "$HOME/.emacs.d/bin"
pathadd "$HOME/Library/Python/3.8/bin"
pathadd "$HOME/.poetry/bin"
pathadd "$HOME/.yarn/bin"
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/go/bin"

brew_prefix=/opt/homebrew
if [[ -d $brew_prefix ]]; then
  eval "$($brew_prefix/bin/brew shellenv)"
  pathadd "$brew_prefix/bin"
  pathadd "$brew_prefix/opt/coreutils/libexec/gnubin"
  pathadd "$brew_prefix/opt/libpq/bin"
  pathadd "$brew_prefix/opt/llvm@11/bin"
  export CFLAGS="-I$brew_prefix/include"
  export LDFLAGS="-L$brew_prefix/lib"
fi

[ -s "$HOME/.nvm/nvm.sh"  ] && source "$HOME/.nvm/nvm.sh"
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

typeset -TU P=$PATH p
export PATH=$P

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export BAT_THEME="TwoDark"
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_DEFAULT_OPTS='--height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
export DJANGO_ENVIRONMENT=local
