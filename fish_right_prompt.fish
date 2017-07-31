# name: jdob

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_right_prompt

  # Colors
  set -l border (set_color magenta)
  set -l green (set_color green)
  set -l red (set_color red)

  set -l blue (set_color blue)
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l magenta (set_color magenta)
  set -l normal (set_color normal)

  set -l line "─"
  set -l bullet "•"
  set -l rt_border "─╮"
  set -l rb_border "─╯"
 
  set -l bl "["

  # Status
  if test $status = 0
    set last_status "$border$bl$border]"
  else
    set last_status "$border$bl$red$status$border]"
  end

  # Git Information
  set -l git_ok "✔"
  set -l git_dirty "✘"

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$git_branch"

    if [ (_is_git_dirty) ]
      set git_info "$yellow$git_info $git_dirty"
    else
      set git_info "$green$git_info $git_ok"
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

  set -l top   "$border$bullet$line$venv_info$border$line$git_info$border$line$last_status$border$rt_border"
  set -l bottom "$border$bullet$rb_border"

  echo -s -n $bottom

end
