local user_host=`fgc 46`'\u'`fgc 11`'@'`fgc 27`'\h'$NOC
local current_dir=`fgc 246`'\w'$NOC
local ruby_prompt=`fgc 160`'‹$(ps1_ruby)›'$NOC
local git_prompt=`fgc 208`'$(ps1_git_status)'`fgc 191`' $(ps1_git_branch)'$NOC

PS1="${user_host} ${current_dir} ${ruby_prompt} ${git_prompt}
÷∞ "
