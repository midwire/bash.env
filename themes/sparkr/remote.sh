
local user_host=`ext_color 46`'\u'`ext_color 11`'@'$BG_RED`ext_color 255`'\h'$NO_COLOR
local current_dir=`ext_color 246`'\w'$NO_COLOR
local rvm_ruby=`ext_color 160`'‹$(rvm-prompt)›'$NO_COLOR
local git_prompt=`ext_color 208`'$(ps1_git_status)'`ext_color 27`' $(ps1_git_branch)'$NO_COLOR

PS1="╭─${user_host} ${current_dir} ${rvm_ruby} ${git_prompt}
╰⊚ "
