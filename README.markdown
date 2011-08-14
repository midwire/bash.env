# .env

Is a comprehensive bash environment system that I've been using for over a decade.

Make sure you customize the individual files to your own taste.

To use it add the following to your $HOME/.bashrc file.

    # Source each *.sh file in the ~/.env folder
    echo "User .bashrc..."
    for i in ~/.env/*.sh ; do
      if [ -r "$i" ]; then
              . $i
      fi
    done
    unset i

