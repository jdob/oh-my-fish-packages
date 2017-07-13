# name: jdob

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l red (set_color red)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l fish "⋊>"
  set -l mac "⌘"
  set -l yinyang "☯"
  set -l smile "☺︎"
  set -l leader $fish

  set -l last_status $status

  if test $last_status = 0
    set prompt "$green$leader$normal "
  else
    set prompt "$red$leader$normal "
  end

  echo -n -s $prompt
end

