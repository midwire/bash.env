# .env

Is my personal bash environment system

To use it add the following to your $HOME/.bashrc file.

    # Source each *.sh file in the ~/.env folder
    echo "User .bashrc..."
    for i in ~/.env/*.sh ; do
      if [ -r "$i" ]; then
              . $i
      fi
    done
    unset i

