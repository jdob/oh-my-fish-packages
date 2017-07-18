# name: jdob

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set fish_color_command (set_color brblue)

  # Colors
  set -l red (set_color red)
  set -l green (set_color green)
  set -l normal (set_color normal)

  # Leader Images
  set -l fish "⋊>"
  set -l mac "⌘"
  set -l yinyang "☯"
  set -l smile "☺︎"
  set -l leader $fish

  # Last command exit code coloring
  if test $status = 0
    set last_status "$green$leader$normal"
  else
    set last_status "$red$leader$normal"
  end

  echo -n -s "$last_status "
end

