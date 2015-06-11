# dummy function to load bash shell script file
# without "command not found: shopt" error
shopt () {}

for RC_FILE in $(find ~/.zshrc.d/ -type f -or -type l | sort); do
    . "${RC_FILE}"
done
