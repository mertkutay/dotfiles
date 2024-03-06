set -x CFLAGS ""
set -x LDFLAGS ""
set -x LD_LIBRARY_PATH ""

function add_path
  if test -d $argv[1]
    set -x PATH $argv[1] $PATH
  end
end

function add_flags
  if test -d $argv[1]
    set -x CFLAGS "-I$argv[1]/include $CFLAGS"
    set -x LDFLAGS "-L$argv[1]/lib $LDFLAGS"
  end
end

function add_ld_library
  if test -d $argv[1]
    set -x LD_LIBRARY_PATH "$argv[1]:$LD_LIBRARY_PATH"
  end
end

add_path "/usr/local/bin"
add_path "/usr/local/sbin"
add_path "$HOME/bin"
add_path "$HOME/.local/bin"
add_path "$HOME/.fzf/bin"
add_path "$HOME/.emacs.d/bin"
add_path "$HOME/.poetry/bin"
add_path "$HOME/.yarn/bin"
add_path "$HOME/.cargo/bin"
add_path "$HOME/go/bin"
add_path "/usr/local/go/bin"

set brew_prefix /opt/homebrew
if test -d $brew_prefix
  eval ($brew_prefix/bin/brew shellenv)
  add_path "$brew_prefix/bin"
  add_path "$brew_prefix/opt/coreutils/libexec/gnubin"
  add_path "$brew_prefix/opt/llvm@10/bin"
  add_path "$brew_prefix/opt/llvm/bin"
  add_path "$brew_prefix/opt/libpq/bin"

  add_flags "$brew_prefix"
  add_flags "$brew_prefix/opt/openssl"
  add_flags "$brew_prefix/opt/libffi"
  add_flags "$brew_prefix/opt/llvm@10"
  add_flags "$brew_prefix/opt/llvm"
  add_flags "$brew_prefix/opt/libpq"
end

set PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
  add_path "$PYENV_ROOT/bin"
end

set --universal nvm_default_version v16.20.0

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
set -x QT_PLUGIN_PATH $COPPELIASIM_ROOT
set -x QT_QPA_PLATFORM_PLUGIN_PATH $COPPELIASIM_ROOT
add_ld_library $COPPELIASIM_ROOT
add_ld_library $HOME/.mujoco/mujoco210/bin
add_ld_library /usr/lib/nvidia

set GC_SDK $HOME/google-cloud-sdk/path.fish.inc
if test -f $GC_SDK
  . $GC_SDK
end

function t
  if [ "$TERM_PROGRAM" != "vscode" ]; \
    and [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]; \
    and test -z "$TMUX" -a -z "$SSH_CLIENT" -a -z "$SSH_TTY"
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
  alias glo="git log --graph --branches --format=format:'%C(auto)%h%C(reset) %C(blue)(%cr)%C(reset) %C(auto)%s%C(reset) %C(dim normal)<%an>%C(reset)%C(auto)%d%C(reset)'"
  alias gsh="git show"
  alias ga="git add"
  alias gm="git merge"
  alias gr="git reset"
  alias ggl="git pull origin (current_branch)"
  alias ggp="git push origin (current_branch)"
  alias gpf="git push --force-with-lease"
  alias gsu="git submodule update"
  alias ggsup="git branch --set-upstream-to=origin/(current_branch)"

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

