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

alias python="python3"
alias pip="pip3"
vew_script=$(which virtualenvwrapper.sh)
if [ -x "$vew_script" ] ; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export WORKON_HOME="$HOME/.virtualenvs"
    source "$vew_script"
    plugins=($plugins virtualenvwrapper)
fi

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

alias t="tmux"
alias ta="tmux attach"
alias tl="tmux ls"
alias ssh="TERM=xterm-256color ssh -A"
alias ls="ls --group-directories-first --color=always"
alias l="ls -lhF"

export EDITOR="$HOME/bin/editor"
export VISUAL="$EDITOR"
alias e="$EDITOR"

if [[ -d $HOME/.fzf ]]; then
  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null
  source "$HOME/.fzf/shell/key-bindings.zsh"
fi

[ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"
