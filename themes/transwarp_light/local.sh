local user_host=''
local current_dir="$(fgc 058)\\w$NOC"
local ruby_prompt="$(fgc 124)‹\$(ps1_ruby)›$NOC"
local git_prompt="$(fgc 208)\$(ps1_git_status)$(fgc 091) \$(ps1_git_branch)$NOC"
local pc=''

# add a fix for Solaris' backward id command
local user_id
user_id=$(id | cut -f1 -d' ' | sed -e 's/(.*$//' | cut -f2 -d'=')

if [[ "$user_id" -eq 0 ]]; then
  # We are root
  user_host="$(fgc 196)\\u$(fgc 11)@$(fgc 27)\\H$NOC"
  pc="$(fgc 196)➤$NOC"
else
  user_host="$(fgc 238)\\u$(fgc 11)@$(fgc 27)\\H$NOC"
  pc="➤$NOC"
fi

PS1="${user_host} ${current_dir} ${ruby_prompt} ${git_prompt}
${pc} "$NOC
