# Show Current Settings
function proxy-show(){
  echo "ALL_PROXY = ($ALL_PROXY)"
  echo "HTTP_PROXY = ($HTTP_PROXY)"
  echo "http_proxy = ($http_proxy)"
  echo "HTTPS_PROXY = ($HTTPS_PROXY)"
  echo "https_proxy = ($https_proxy)"
  echo "ftp_proxy = ($ftp_proxy)"
  echo "rsync_proxy = ($rsync_proxy)"
  echo "no_proxy = ($no_proxy)"
  echo "NO_PROXY = ($NO_PROXY)"
}

# Enable Proxy
function proxy-on(){
  export ALL_PROXY=http://localhost:8888
  export HTTP_PROXY=$ALL_PROXY
  export http_proxy=$ALL_PROXY
  export HTTPS_PROXY=$ALL_PROXY
  export https_proxy=$ALL_PROXY
  export ftp_proxy=$ALL_PROXY
  export rsync_proxy=$ALL_PROXY
  # export NO_PROXY=localhost,.local,169.254.,127.0.0.1,10.0.2.,.domain.com,/var/run/docker.sock
  export NO_PROXY=/var/run/docker.sock
  export no_proxy=$NO_PROXY
  proxy-show
}

# Disable Proxy
function proxy-off(){
  unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy ftp_proxy rsync_proxy ALL_PROXY NO_PROXY no_proxy
  proxy-show
}

# Turn on by default
proxy-on
