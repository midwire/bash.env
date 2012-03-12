
local user_host=`fgc 46`'\u'`fgc 11`'@'`fgc 27`'\h'$NOC
local current_dir=`fgc 246`'\w'$NOC
local rvm_ruby=`fgc 160`'‹$(rvm-prompt)›'$NOC
local git_prompt=`fgc 208`'$(ps1_git_status)'`fgc 191`' $(ps1_git_branch)'$NOC

PS1="╭─${user_host} ${current_dir} ${rvm_ruby} ${git_prompt}
╰⊚ "
