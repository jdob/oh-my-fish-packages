# name: jdob

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_right_prompt

  # Colors
  set -l blue (set_color blue)
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l magenta (set_color magenta)
  set -l normal (set_color normal)

  # Directory Information
  set -g fish_prompt_pwd_dir_length 3
  set -l path (prompt_pwd)
  set -l directory_info "$magenta$path$normal"

  # Git Information
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$git_branch"

    if [ (_is_git_dirty) ]
      set git_info "$yellow$git_info"
    else
      set git_info "$blue$git_info"
    end

    set git_info "$cyan($git_info$cyan)$normal"
  end

  # Virtual Environment Information
  if set -q VIRTUAL_ENV
    set venv_info (basename "$VIRTUAL_ENV")
    set venv_info "$cyan($blue$venv_info$cyan)$normal"
  else
    set venv_info ""
  end

  echo -n -s "$venv_info $git_info $directory_info"
end
