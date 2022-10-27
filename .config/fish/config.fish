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
  function flagadd
    set lib_dir "$brew_prefix$argv[1]"
    if test -d lib_dir
      set -x CFLAGS "$CFLAGS -I$lib_dir/include"
      set -x LDFLAGS "$LDFLAGS -L$lib_dir/lib"
    end
  end

  eval ($brew_prefix/bin/brew shellenv)
  pathadd "$brew_prefix/bin"
  pathadd "$brew_prefix/opt/coreutils/libexec/gnubin"
  pathadd "$brew_prefix/opt/llvm@10/bin"
  pathadd "$brew_prefix/opt/libpq/bin"
  flagadd ""
  flagadd "/opt/openssl"
  flagadd "/opt/libffi"
  flagadd "/opt/llvm@10"
  flagadd "/opt/libpq"
end

set PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
  pathadd "$PYENV_ROOT/bin"
end

set --universal nvm_default_version v16.16.0

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x EDITOR "nvim"

set -x WORKON_HOME $HOME/.virtualenvs
set -x PROJECT_HOME $HOME/projects

set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x DOCKER_BUILDKIT 1

set -x BAT_THEME "gruvbox-dark"

set -x LLVM_CONFIG (which llvm-config)

set -x COPPELIASIM_ROOT $HOME/coppelia
set -x LD_LIBRARY_PATH $COPPELIASIM_ROOT:$LD_LIBRARY_PATH
set -x QT_QPA_PLATFORM_PLUGIN_PATH $COPPELIASIM_ROOT

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

  set -x TERM xterm-256color

  set -x LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"

  set -x TERM xterm-256color

  alias python="python3"
  alias pip="pip3"
  alias ta="tmux attach"
  alias tl="tmux ls"
  alias vim="nvim"
  alias lg="lazygit"

  alias gst="git status"
  alias gd="git diff"
  alias gl="git pull"
  alias gp="git push"
  alias gcmsg="git commit -m"
  alias gco="git checkout"
  alias gcb="git checkout -b"
  alias gb="git branch"
  alias gcp="git cherry-pick"
  alias glo="git log --oneline"
  alias gsh="git show"
  alias ga="git add"
  alias gm="git merge"
  alias gr="git reset"
  alias ggl="git pull origin (current_branch)"
  alias ggp="git push origin (current_branch)"
  alias gpf="git push --force-with-lease"
  alias gsu="git submodule update"
  alias ggsup="git branch --set-upstream-to=origin/(current_branch)"

  pyenv init - | source
  direnv hook fish | source
  starship init fish | source

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
