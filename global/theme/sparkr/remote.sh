if [ $UID -eq 0 ]; then
PS1="╭─${TITLEBAR}\
${BG_RED}${LIGHT_WHITE}\u@\h${CYAN} \w\
${RED} <\${ruby_ver}>\
${YELLOW} (\${branch})\
${WHITE} (\${RAILS_ENV})\n\
${LIGHT_RED}∹\
$NO_COLOR "
else
PS1="╭─${TITLEBAR}\
${BG_RED}${LIGHT_GREEN}\u@\h${CYAN} \w\
${RED} <\${ruby_ver}>\
${YELLOW} (\${branch})\
${WHITE} (\${RAILS_ENV})\n\
${WHITE}⊱\
$NO_COLOR "
fi
