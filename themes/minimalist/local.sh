local user_host=''
local current_dir=`fgc 249`'\w'$NOC
local pc=''

# add a fix for Solaris' backward id command
id=`id |cut -f1 -d' '|sed -e 's/(.*$//'|cut -f2 -d'='`

if [ "$id" -eq 0 ]; then
  user_host=`fgc 196`'\u'`fgc 11`'@'`fgc 46`'\h'$NOC
  pc=`fgc 196`➤$NOC
else
  user_host=`fgc 46`'\u'`fgc 11`'@'`fgc 27`'\h'$NOC
  pc=➤$NOC
fi

PS1="${user_host} ${current_dir}
${pc} "$NOC
