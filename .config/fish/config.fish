set fish_greeting

fish_vi_key_bindings

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--bind=ctrl-u:page-up,ctrl-d:page-down'

function fzf_reverse_isearch
  history merge
  history --show-time="%Y-%m-%d # " -z | fzf --read0 --print0 --tiebreak=index | sed 's/^[0-9-]\{10\} # //' | read -lz result
  and commandline -- $result
  commandline -f repaint
end

function fish_user_key_bindings
  bind -M insert -k nul accept-autosuggestion
  bind -M insert \e\[C forward-word
  bind -M insert \e\[D backward-word
  bind -M insert \cR fzf_reverse_isearch
end

function fish_title
  set folderNamePattern 's#^.*/##'
  set title (pwd | sed $folderNamePattern)

  if test "$NVIM_LISTEN_ADDRESS" = ""
    tmux rename-window $title
  end

  echo $title
end

alias copy="pbcopy"
alias paste="pbpaste"

# https://github.com/sharkdp/bat
export BAT_THEME=Nord
alias cat="bat"

# dotfiles bare repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if status is-interactive
  # https://github.com/starship/starship#fish
  starship init fish | source

  # https://github.com/gsamokovarov/jump
  source (jump shell fish | psub)

  # https://asdf-vm.com/#/core-manage-asdf-vm?id=add-to-your-shell
  # source ~/.asdf/asdf.fish

  set -U fish_color_command brwhite
  set -U fish_color_param brblue
  set -U fish_color_end brgreen
  set -U fish_color_quote yellow
  set -U fish_color_redirection magenta
  set -U fish_color_error red
  set -U fish_color_comment brblack
  set -U fish_color_autosuggestion brblack
end
