#------------
# Processes:
#------------
# Process Find Aliases
alias pfn='ps -e -o euser,pid,args | grep'

# pstree: support both Intel and Apple Silicon Homebrew paths
if [[ -x /opt/homebrew/bin/pstree ]]; then
  alias pstree='/opt/homebrew/bin/pstree -g 2 -w'
elif [[ -x /usr/local/bin/pstree ]]; then
  alias pstree='/usr/local/bin/pstree -g 2 -w'
fi

# to find memory hogs:
alias mem_hogs_top='top -l 1 -o rsize -n 10'
alias mem_hogs_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# to find CPU hogs
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# continual 'top' listing (every 10 seconds) showing top 15 CPU consumers
alias topforever='top -l 0 -s 10 -o cpu -n 15'

# diskwho: to show processes reading/writing to disk
# Note: requires either fs_usage (built-in) or iotop (brew install iotop)
if command -v iotop &>/dev/null; then
  alias diskwho='sudo iotop'
else
  alias diskwho='sudo fs_usage -f diskio'
fi

#------------
# Networking:
#------------
# lsock: to display open sockets (the -P option to lsof disables port names)
alias lsock='sudo /usr/sbin/lsof -i -P'

# airport: Apple's command-line tool. For status info, use -I, for help use -h
if [[ -x /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport ]]; then
  alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
elif [[ -x /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport ]]; then
  alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'
fi

# Get current WiFi network name
alias wifi_name='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: "/^ *SSID/{print \$2}"'

# ip_info: to get info on DHCP server, router, DNS server, etc
# Automatically detects the primary network interface
alias ip_info='ipconfig getpacket "$(networksetup -listallhardwareports | awk "/Wi-Fi|Ethernet/{getline; print \$2}" | head -1)"'

# Show local IP address
alias localip='ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null'

# Show public IP address
alias publicip='curl -s https://api.ipify.org && echo'

# browse_bonjour: browse services advertised via Bonjour
# Note: need to supply a "type" argument- e.g. "_http._tcp"
# See http://www.dns-sd.org/ServiceTypes.html for more types
alias browse_bonjour='dns-sd -B'

# Flush DNS cache (works on modern macOS)
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# pkt_trace: packet tracing using tcpflow
# Note: requires tcpflow (brew install tcpflow)
if command -v tcpflow &>/dev/null; then
  alias pkt_trace='sudo tcpflow -i "$(route -n get default 2>/dev/null | awk "/interface:/{print \$2}")" -c'
  alias smtp_trace='pkt_trace port smtp'
  alias http_trace='pkt_trace port 80'
  alias tcp_trace='pkt_trace tcp'
  alias udp_trace='pkt_trace udp'
  alias ip_trace='pkt_trace ip'
fi

#------
# Misc:
#------
# epochtime: report number of seconds since the Epoch
alias epochtime='date +%s'

# screensaverdesktop: run a screensaver on the Desktop
alias screensaverdesktop='/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

# Launch apps from terminal
alias consoleapp='open -a Console'
alias activitymonitor='open -a "Activity Monitor"'
alias syspreferences='open -a "System Preferences" 2>/dev/null || open -a "System Settings"'

#---------------------------
# System operations & info:
#---------------------------
# install all software updates from the command line
alias software_update='sudo softwareupdate -i -a'
alias software_check='softwareupdate -l'

# third_party_kexts: to check for non-Apple kernel extensions
alias third_party_kexts='kextstat | grep -v com.apple'

# show_optical_disk_info - e.g. what type of CD & DVD media is supported
alias show_optical_disk_info='drutil info'

# remove_disk: spin down unneeded disk
alias eject_disk='diskutil eject'

# mount_read_write: for use when booted into single-user
alias mount_read_write='/sbin/mount -uw /'

# netparams: to show values of network parameters in the kernel
alias netparams='sysctl -a | grep net'

# swapinfo: to display info on swap
alias swapinfo='sysctl vm.swapusage'

# Show macOS version
alias macosver='sw_vers'

# Restart Finder
alias restartfinder='killall Finder'

# Restart Dock
alias restartdock='killall Dock'

# Empty trash
alias emptytrash='rm -rf ~/.Trash/*'

# Show/hide hidden files in Finder (modern syntax)
alias finderShowHidden='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias finderHideHidden='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# finderTurnOffDesktop: turn off display of files on the Desktop
alias finderTurnOffDesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias finderTurnOnDesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Stop Finder from writing .DS_Store files on network volumes
alias dsstore_network_off='defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true'
alias dsstore_network_on='defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool false'

# lsregister: utility for looking at the Launch Services database
alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'

# to read a single key press:
alias keypress='read -s -n1 keypress; echo $keypress'

#--------
# Clipboard:
#--------
# Copy/paste from command line
alias pbp='pbpaste'
alias pbc='pbcopy'

#--------
# Sleep/Power:
#--------
# Put display to sleep
alias displaysleep='pmset displaysleepnow'

# Prevent sleep while running a command: caffeinate -i <command>
alias nosleep='caffeinate -i'

# Show battery status
alias battery='pmset -g batt'
