function pathadd
  if test -d $argv[1]
    set -x PATH $argv[1] $PATH
  end
end

pathadd "/usr/local/bin"
pathadd "/usr/local/sbin"
pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/.fzf/bin"
pathadd "$HOME/.emacs.d/bin"
pathadd "$HOME/.poetry/bin"
pathadd "$HOME/.yarn/bin"
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/go/bin"
pathadd "/usr/local/go/bin"

set brew_prefix /opt/homebrew
if test -d $brew_prefix
  eval "$($brew_prefix/bin/brew shellenv)"
  pathadd "$brew_prefix/bin"
  pathadd "$brew_prefix/opt/coreutils/libexec/gnubin"
  pathadd "$brew_prefix/opt/libpq/bin"
  pathadd "$brew_prefix/opt/llvm@11/bin"
  set -x CFLAGS "-I$brew_prefix/include"
  set -x LDFLAGS "-L$brew_prefix/lib"
end

if test -d "$brew_prefix/opt/openssl"
  set -x CFLAGS "$CFLAGS -I$brew_prefix/opt/openssl/include"
  set -x LDFLAGS "$LDFLAGS -L$brew_prefix/opt/openssl/lib"
end

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x EDITOR "nvim"

set -x WORKON_HOME $HOME/.virtualenvs
set -x PROJECT_HOME $HOME/projects

set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x DOCKER_BUILDKIT 1


function t
  if [ "$TERM_PROGRAM" != "vscode" ]; and test -z "$TMUX" -a -z "$SSH_CLIENT" -a -z "$SSH_TTY"
    set session_name "default"
    tmux has-session -t=$session_name 2> /dev/null
    if test $status -eq 1
      tmux new-session -s "$session_name"
    else
      tmux attach-session -t "$session_name"
    end
  end
end

function current_branch
  set ref (git symbolic-ref HEAD 2> /dev/null); or \
  set ref (git rev-parse --short HEAD 2> /dev/null); or return
  echo $ref | sed s-refs/heads/--
end

if status is-login
  pyenv init --path | source
end

if status is-interactive
  fish_vi_key_bindings

  alias python="python3"
  alias pip="pip3"
  alias ta="tmux attach"
  alias tl="tmux ls"
  alias vim="nvim"

  alias gst="git status"
  alias gd="git diff"
  alias gl="git pull"
  alias gp="git push"
  alias gcmsg="git commit -m"
  alias gco="git checkout"
  alias gb="git branch"
  alias gcp="git cherry-pick"
  alias glo="git log --oneline"
  alias ga="git add"
  alias gm="git merge"
  alias gr="git reset"
  alias ggl='git pull origin (current_branch)'
  alias ggp='git push origin (current_branch)'

  pyenv init - | source
  direnv hook fish | source

  t
end

if test "$TERM" = "dumb"
  function fish_prompt
    echo "\$ "
  end

  function fish_right_prompt; end
  function fish_greeting; end
  function fish_title; end
end
