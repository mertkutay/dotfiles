PATH="/usr/local/bin:$PATH"
[ -d "/usr/local/sbin" ] && PATH="/usr/local/sbin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -d "$HOME/.fzf/bin" ] && PATH="$HOME/.fzf/bin:$PATH"
[ -d "$HOME/.emacs.d/bin" ] && PATH="$HOME/.emacs.d/bin:$PATH"
[ -d "$HOME/Library/Python/3.8/bin" ] && PATH="$HOME/Library/Python/3.8/bin:$PATH"
[ -d "$HOME/.poetry/bin" ] && PATH="$HOME/.poetry/bin:$PATH"
[ -d "$HOME/.yarn/bin" ] && PATH="$HOME/.yarn/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

brew_prefix=/opt/homebrew
if [[ -d $brew_prefix ]]; then
  eval "$($brew_prefix/bin/brew shellenv)"
  export CFLAGS="-I$brew_prefix/include"
  export LDFLAGS="-L$brew_prefix/lib"
  [ -d "$brew_prefix/bin" ] && PATH="$brew_prefix/bin:$PATH"
  [ -d "$brew_prefix/opt/coreutils/libexec/gnubin" ] && PATH="$brew_prefix/opt/coreutils/libexec/gnubin:$PATH"
  [ -d "$brew_prefix/opt/libpq" ] && PATH="$brew_prefix/opt/libpq/bin:$PATH"
  [ -d "$brew_prefix/opt/llvm@11" ] && PATH="$brew_prefix/opt/llvm@11/bin:$PATH"
  [ -d "$brew_prefix/opt/openblas" ] && export OPENBLAS="$brew_prefix/opt/openblas"
fi

typeset -a paths result
paths=($path)

while [[ ${#paths} -gt 0 ]]; do
  p="${paths[1]}"
  shift paths
  [[ -z ${paths[(r)$p]} ]] && result+="$p"
done

clean_path=${(j+:+)result}
export PATH
export PATH=$clean_path

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export DOCKER_BUILDKIT=1
export BAT_THEME="TwoDark"
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_DEFAULT_OPTS='--height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
export DJANGO_ENVIRONMENT=local
