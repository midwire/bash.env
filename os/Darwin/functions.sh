# cdf: cd's to frontmost window of Finder
cdf () {
	currFolderPath=$( /usr/bin/osascript <<"EOT"
	  tell application "Finder"
	    try
	      set currFolder to (folder of the front window as alias)
	    on error
	      set currFolder to (path to desktop folder as alias)
	    end try
	    POSIX path of currFolder
	  end tell
EOT
	)
	echo "cd to \"$currFolderPath\""
	cd "$currFolderPath"
}

# File Finders
# ff:  to find a file under the current directory
ff () { /usr/bin/find . -name "$@" ; }
# ffs: to find a file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }
# ffe: to find a file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }

# SPOTLIGHT
# locatemd: to search for a file using Spotlight's metadata
function locatemd { mdfind "kMDItemDisplayName == '$@'wc"; }
# locaterecent: to search for files created since yesterday using Spotlight
# This is an illustration of using $time in a query
# See: http://developer.apple.com/documentation/Carbon/Conceptual/SpotlightQuery/index.html
function locaterecent { mdfind 'kMDItemFSCreationDate >= $time.yesterday'; }

# list_all_apps: list all applications on the system
list_all_apps() { mdfind 'kMDItemContentTypeTree == "com.apple.application"c' ; }

# find_larger: find files larger than a certain size (in bytes)
find_larger() { find . -type f -size +${1}c ; }

# findPid: find out the pid of a specified process
#    Note that the command name can be specified via a regex
#    E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#    Without the 'sudo' it will only find processes of the current user
findPid () { sudo /usr/sbin/lsof -t -c "$@" ; }


# debug_http: download a web page and show info on what took time
debug_http () { /usr/bin/curl $@ -o /dev/null -s -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

# http_headers: get just the HTTP headers from a web page (and its redirects)
http_headers () { /usr/bin/curl -I -L $@ ; }

# can use 'scselect' to find out current network "location"
# can use 'scutil' for other system config stuff

# to do socket programming in bash, redirect to /dev/tcp/$host/$port
# Example:
osaClient () {
    exec 5<> /dev/tcp/localhost/4321
    cat $1 >&5
    echo "-- end of file" >&5
    cat <&5
    exec 5>&-
}


# get info about system via AppleScript
applescript_info () {
    info=$( /usr/bin/osascript <<"    EOT"
        system info
    EOT
    )
    echo $info
}

# to mount a read-only disk image as read-write:
# hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

# mounting a removable drive (of type msdos or hfs)
# mkdir /Volumes/Foo
# ls /dev/disk*   to find out the device to use in the mount command)
# mount -t msdos /dev/disk1s1 /Volumes/Foo
# mount -t hfs /dev/disk1s1 /Volumes/Foo

# to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
# e.g.: mkfile 10m 10MB.dat
# e.g.: hdiutil create -size 10m 10MB.dmg
# the above create files that are almost all zeros - if random bytes are desired
# then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

# making a hard-link backup of a directory
# rsync -a --delete --link-dest=$DIR $DIR /backup/path/for/dir

# ql: show a "Quick Look" view of files
ql () { /usr/bin/qlmanage -p "$@" >& /dev/null & }


#-----------------
# Misc Reminders:
#-----------------

# To find idle time: look for HIDIdleTime in output of 'ioreg -c IOHIDSystem'

# to set the delay for drag & drop of text (integer number of milliseconds)
# defaults write -g NSDragAndDropTextDelay -int 100

# URL for a man page (example): x-man-page://3/malloc

# to compile an AppleScript file to a resource-fork in the source file:
osacompile_rsrc () { osacompile -x -r scpt:128 -o $1 $1; }

# alternative to the use of 'basename' for usage statements: ${0##*/}

# graphical operations, image manipulation: sips

# numerical user id: 'id -u'
# e.g.: ls -l /private/var/tmp/mds/$(id -u)
