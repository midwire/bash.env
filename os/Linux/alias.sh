# Editing and Sourcing aliases
alias ees='. $HOME/.env/bash.env.sh'
# alias bigfind="sudo find . -type f -size +30000k -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'"

#------------
# Date/Time
#------------
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

#------------
# Networking
#------------
alias ports='netstat -tulanp'

## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'

# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

#------------
# Mem/CPU
#------------
## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

#------------
# Disk
#------------
alias dfree='df -HPT'
