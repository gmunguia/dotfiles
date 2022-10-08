set fish_greeting

fish_vi_key_bindings

export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

export EDITOR=hx

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
  abbr h "hx"

  # cd into root directory of current repository.
  abbr cdr 'test -n (git rev-parse --show-cdup) && cd (git rev-parse --show-cdup)'

  abbr less "less -MNi"

  # dotfiles bare repo
  alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

  # sed on all files at once
  abbr findreplace "fd '.*' -t f --print0 | xargs -0 sed -i '' -E"

  # fuzzy-find a folder and cd into it
  abbr j "cd (fd '.*' -t d --exclude Caches | fzf)"

  abbr ps procs -w -W 2 --sortd CPU

  abbr week date +%V

  # https://github.com/starship/starship#fish
  starship init fish | source

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

  export TMUX_WINDOW_ID=(tmux list-windows | grep active | sed -E 's/^.*(@[0-9]+) .*$/\1/')
  function fish_title
    set title (basename (pwd))

    # I don't want the window title to change when commands run in Neovim integrated terminal.
    if not set -q NVIM_LISTEN_ADDRESS
      # `fish_title` runs before and after commands. `rename-window` renames the currently active window by default. Without targetting, long commands that finish after I have switched windows will cause the wrong window to be renamed.
      tmux rename-window -t $TMUX_WINDOW_ID $title
    end

    echo $title
  end

  function open_typescript
    sed 's/\x1B\[[0-9;]*[JKmsu]//g' $script_file_name > $script_file_name".txt"
    # `:n` opens at the nth line. `:9999999` is a workaround to open file at the end.
    tmux new-window "hx "$script_file_name".txt:999999"
  end
  abbr e open_typescript

  # The session started by `script` will run this config.fish file. SCRIPT is set by `script` to prevent endless recursion.
  if not set -q SCRIPT
    set date (date -u "+%Y-%m-%dT%H:%M:%SZ")
    set uuid (string lower (uuidgen))
    set script_file_name "/tmp/typescripts/"$date"-"$uuid
    export script_file_name
    mkdir -p "/tmp/typescripts"

    exec script -t 1 -q $script_file_name
  end
end
