ZSH="$HOME/.oh-my-zsh"

DEFAULT_USER=`whoami`
HIST_STAMPS="mm/dd/yyyy"
DISABLE_UPDATE_PROMPT="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    git
    colorize
    zsh-autosuggestions
    zsh-syntax-highlighting
)

setopt autolist
setopt cdablevars
setopt autonamedirs
setopt histignoredups
setopt listtypes
setopt nolistbeep

source $ZSH/oh-my-zsh.sh
ZSH_THEME=""
fpath+=$ZSH_CUSTOM/themes/pure
autoload -U promptinit; promptinit
prompt pure

bindkey -v
bindkey '^R' history-incremental-search-backward

source "$HOME/.dotfiles/.zsh_functions"
autoload -U add-zsh-hook
add-zsh-hook chpwd check_venv

alias ta='tmux attach'
alias tl='tmux ls'
alias ssh='TERM=xterm-256color ssh -A'

export EDITOR=emacsclient
export VISUAL="$EDITOR"

if [[ -d $HOME/.fzf ]]; then
  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null
  source "$HOME/.fzf/shell/key-bindings.zsh"
fi

[ -s "$HOME/.nvm/nvm.sh"  ] && source "$HOME/.nvm/nvm.sh"
[ -s "$HOME/.nvm/bash_completion"  ] && source "$HOME/.nvm/bash_completion"
