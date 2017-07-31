# name: jdob

function fish_right_prompt

  # Colors
  set -l border (set_color magenta)
  set -l normal (set_color normal)

  # Widgets
  set -l line "─"
  set -l bullet "•"
  set -l rb_border "─╯"
 
  # Bottom Right Prompt
  set -l bottom "$border$bullet$rb_border$normal"

  echo -s -n $bottom

end
