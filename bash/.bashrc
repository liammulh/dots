##################################################
# Options
##################################################

# Use Vi mode.
set -o vi

##################################################
# Variables
##################################################

# Set default editor.
export VISUAL="nvim"
export EDITOR="nvim"

##################################################
# Aliases
##################################################

alias ..="cd .."
alias c="clear"
alias l="ls -ahl"
alias e=$EDITOR
alias q="exit"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

    # Copy shit to the system clipboard.
    alias pbcopy="xclip -selection clipboard"

    # Paste shit from the system clipboard to stdout.
    alias pbpaste="xclip -selection clipboard -out"
fi
