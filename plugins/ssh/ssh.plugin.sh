# Add all SSH keys to the running agent

KEYS=`ls -1 ~/.ssh/id_* | grep -v ".pub"`

for k in $KEYS ; do
  ssh-add "$k"
done
