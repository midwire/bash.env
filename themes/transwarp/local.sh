local user_host=''
local current_dir=`fgc 075`'\w'$NOC
local ruby_prompt=`fgc 009`'‹$(ps1_ruby)›'$NOC
local git_prompt=`fgc 208`'$(ps1_git_status)'`fgc 191`' $(ps1_git_branch)'$NOC
local pc=''

# add a fix for Solaris' backward id command
id=`id |cut -f1 -d' '|sed -e 's/(.*$//'|cut -f2 -d'='`

if [ "$id" -eq 0 ]; then
  # We are root
  user_host=`fgc 196`'\u'`fgc 11`'@'`fgc 27`'\H'$NOC
  pc=`fgc 196`➤$NOC
else
  user_host=`fgc 238`'\u'`fgc 11`'@'`fgc 27`'\H'$NOC
  pc=➤$NOC
fi

PS1="${user_host} ${current_dir} ${ruby_prompt} ${git_prompt}
${pc} "$NOC
