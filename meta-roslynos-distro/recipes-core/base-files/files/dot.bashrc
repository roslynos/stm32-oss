# ~/.bashrc: executed by bash(1) for non-login shells.

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
umask 022

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export LS_OPTIONS='--color=auto'

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias dir='dir $LS_OPTIONS'
alias vdir='vdir $LS_OPTIONS'
alias grep='grep $LS_OPTIONS'
alias fgrep='fgrep $LS_OPTIONS'
alias egrep='egrep $LS_OPTIONS'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'