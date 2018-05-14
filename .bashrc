# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# alias vim="nvim"

if [ -z "$DISPLAY" ]
then
	export CSCOPE_EDITOR=vim
else
	export CSCOPE_EDITOR=gvim
fi
export CSCOPE_DB=/BROWSE/cscope.out
export PATH=${PATH}:~/.local/bin

