# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# alias vim="nvim"

export CSCOPE_EDITOR=vim
export CSCOPE_DB=/BROWSE/cscope.out
export PATH=${PATH}:~/.local/bin

