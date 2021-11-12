# Add all SSH keys to the running agent

KEYS=`ls -1 ~/.ssh/id_* | grep -v ".pub"`

# Initialize ssh-agent if not running
pgrep -fx ssh-agent
if [ $? -ne 0 ]; then
  eval "$(ssh-agent)"
fi

for k in $KEYS ; do
  ssh-add "$k"
done
