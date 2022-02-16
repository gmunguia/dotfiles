set fish_greeting

set -U fish_user_paths /opt/homebrew/bin $fish_user_paths

# Lunarvim is installed in ~/.local/bin
set -U fish_user_paths ~/.local/bin $fish_user_paths

fish_vi_key_bindings

export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

export EDITOR=lvim

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--bind=ctrl-u:page-up,ctrl-d:page-down'

function fzf_reverse_isearch
  history merge
  set removeTimestampPattern 's/^[0-9-]\{10\} # //'
  history --show-time="%Y-%m-%d # " -z | fzf --read0 --print0 --tiebreak=index --query=(commandline) | sed $removeTimestampPattern | read -lz result
  and commandline -- $result
  commandline -f repaint
end

function fish_user_key_bindings
  bind -M insert -k nul accept-autosuggestion
  bind -M insert \e\[C nextd-or-forward-word
  bind -M insert \e\[D prevd-or-backward-word
  bind -M insert \cR fzf_reverse_isearch
  bind -M insert \cF edit_command_buffer
  bind -M command \cF edit_command_buffer
end

function fish_title
  set dirnamePattern 's#^.*/##'
  set title (pwd | sed $dirnamePattern)

  if test "$NVIM_LISTEN_ADDRESS" = ""
    tmux rename-window $title
  end

  echo $title
end

if status is-interactive
  alias copy="pbcopy"
  alias paste="pbpaste"

  # https://github.com/sharkdp/bat
  export BAT_THEME=Nord
  abbr cat "bat"

  abbr x "exa -lhFa"
  abbr g "git"
  abbr v "nvim"
  abbr l "lvim"

  abbr .. "cd .."
  abbr ... "cd ../.."
  abbr .... "cd ../../.."

  # cd into root directory of current repository.
  abbr cdr 'test -n (git rev-parse --show-cdup) && cd (git rev-parse --show-cdup)'

  abbr less "less -MNi"

  # dotfiles bare repo
  alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

  # sed on all files at once
  abbr findreplace "fd '.*' -t f --print0 | xargs -0 sed -i '' -E"

  # fuzzy-find a folder and cd into it
  abbr f "cd (fd '.*' -t d --exclude Caches | fzf)"

  # https://github.com/ranger/ranger
  abbr r ranger

  abbr ps procs -w -W 2 --sortd CPU

  abbr week date +%V

  # https://github.com/starship/starship#fish
  starship init fish | source

  # https://github.com/gsamokovarov/jump
  source (jump shell fish | psub)

  # https://asdf-vm.com/#/core-manage-asdf?id=add-to-your-shell
  source (brew --prefix asdf)"/libexec/asdf.fish"

  # https://www.nordtheme.com/docs/ports/dircolors/installation
  test -r ~/.dir_colors && gdircolors -c ~/.dir_colors | source

  set -U fish_color_command brwhite
  set -U fish_color_param brblue
  set -U fish_color_end brgreen
  set -U fish_color_quote yellow
  set -U fish_color_redirection magenta
  set -U fish_color_error red
  set -U fish_color_comment brblack
  set -U fish_color_autosuggestion brblack
end
