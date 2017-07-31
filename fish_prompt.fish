# name: jdob

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _visual_length --description\
    "Return visual length of string, i.e. without terminal escape sequences"
    printf $argv | perl -pe 's/\x1b.*?[mGKH]//g' | wc -m
end

function _append --no-scope-shadowing
    set $argv[1] "$$argv[1]""$argv[2]"
end

function _echo_color --description\
    "Echo last arg with color specified by earlier args for set_color"
    # Example: echo_color -b $bg_color -o aa55ff ':'
    set s $argv[-1]
    set -e argv[-1]
    set_color $argv
    echo -n $s
    set_color normal
    echo
end

function fish_prompt
  set -l last_command_status $status

  set fish_color_command (set_color brblue)

  # Colors
  set -l border (set_color magenta)
  set -l dir_info (set_color green)
  set -l normal (set_color normal)

  set -l red (set_color red)
  set -l yellow (set_color yellow)
  set -l green (set_color green)
  set -l cyan (set_color cyan)
  set -l blue (set_color blue)
  set -l magenta (set_color magenta)

  # Widgets
  set -l line "─"
  set -l bullet "•"
  set -l tl_border "╭─"
  set -l bl_border "╰─"
  set -l rt_border "─╮"
  set -l rb_border "─╯"
  set -l bl "["

  # Random Unused Widgets
  set -l fish "⋊>"
  set -l mac "⌘"
  set -l yinyang "☯"
  set -l smile "☺︎"
  set -l arrow "➤"

  # Directory
  set -g fish_prompt_pwd_dir_length 3
  set -l path (prompt_pwd)
  set -l directory_info "$dir_info$path$normal"

  # Status
  if test $last_command_status -eq 0
    set last_status "$border$bl$green$last_command_status$border]"
  else
    set last_status "$border$bl$red$last_command_status$border]"
  end

  # Git Information
  set -l git_ok "$green✔"
  set -l git_dirty "$red✘"

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$git_branch"

    if [ (_is_git_dirty) ]
      set git_info "$cyan$git_info $git_dirty"
    else
      set git_info "$cyan$git_info $git_ok"
    end

    set git_info "$border$bl$git_info$border]$normal"
  end

  # Virtual Environment Information
  if set -q VIRTUAL_ENV
    set venv_info (basename "$VIRTUAL_ENV")
    set venv_info "$border$bl$blue$venv_info$border]"
  else
    set venv_info "[]"
  end

  set -l l_top    "$border$tl_border$bl$directory_info$border]$line$bullet"
  set -l l_bottom "$border$bl_border$line$bullet$normal "
  set -l r_top   "$border$bullet$line$venv_info$border$line$git_info$border$line$last_status$border$rt_border"

  # set -l l_top    "$border$bullet$line$bl$directory_info$border]$line$bullet"
  # set -l l_bottom "$border$bullet$line$arrow "
  # set -l r_top   "$border$bullet$line$venv_info$border$line$git_info$border$line$last_status$border$line$bullet"

  # Padding
  set -l left_length (_visual_length $l_top)
  set -l right_length (_visual_length $r_top)
  set -l spaces (math "$COLUMNS - $left_length - $right_length")

  # Background coloring -- screw with this later
  # set -l bg_color 666666
  # set_color -b $bg_color

  echo -s -n $l_top
  printf "%-"$spaces"s" " "
  echo -s $r_top

  echo -s -n $l_bottom
end

