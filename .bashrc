# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
#alias l='ls -CF'
#alias fire='copyq && echo "CopyQ started" || & /opt/firefox/firefox && echo "Firefox Executed" &'

alias fire='(copyq && echo "CopyQ started" || echo "CopyQ failed") & /opt/firefox/firefox && echo "Firefox Executed" &'

alias wh='snap run whatsapp-for-linux && echo "WhatsApp started" || echo "WhatsApp failed" & snap run brave && echo "Brave started" || echo "Brave failed" & snap run telegram-desktop && echo "Telegram started" || echo "Telegram failed" & wait'
alias e='exit'
alias l='ls -lt'
alias cl='clear'
alias up='source /home/zero/.KillerScript/.up.sh' 
alias all='snap run whatsdesk & snap run telegram-desktop & snap run spotify &  brave-browser && echo "Successful Execution" &'
alias c='function c() {
  cd "$1" && ls -lt --group-directories-first
}; c'

alias mem='top -o %MEM'
alias tel='snap run telegram-desktop &'
alias cln='npm cache clean --force && echo \"npm cache cleaned successfully\"'
alias clr='npm cache clear --force && echo \"npm cache cleared successfully\"'
alias netof='sudo nmcli networking of'
alias neton='sudo nmcli networking on'
alias 243='ssh strprod@10.240.42.243 -p 22'
alias newline='echo -e'

alias spr='/opt/sts-4.22.1.RELEASE/SpringToolSuite4 &'

alias battery='source /home/zero/.KillerScript/.battery.sh'



alias ini='cd Downloads/firefox/ ; ./firefox & cd .. ; cd Postman/ ; ./Postman & cd .. ; cd .. ; copyq & echo "Successful Execution"'

alias log='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold >'

alias disk='df -h'
alias cat='batcat'




# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert



alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


alias list_by_type='function _list_by_type() { 
  current_dir=$(pwd)
  echo -e "\e[1;33mListing files and directories in: $current_dir\e[0m\n"  # Print header in yellow
  
  # Group files and directories by MIME type
  find "$current_dir" -maxdepth 1 -mindepth 1 -type f -o -type d | xargs -r -I {} file --mime-type {} | awk -F: '\''{print $2}'\'' | sort | uniq | while read type; do 
    # Color selection based on type
    case "$type" in
      inode/directory) color="\e[1;36m" ;;  # Cyan for directories
      text/*) color="\e[1;32m" ;;           # Green for text files
      application/*) color="\e[1;35m" ;;   # Magenta for application files
      image/*) color="\e[1;34m" ;;         # Blue for image files
      *) color="\e[1;37m" ;;               # White for other files
    esac
    
    # Print file type group header
    echo -e "${color}Files/Directories of type: $type\e[0m"; 
    
    # Find and list files/directories of this type, sorted by creation time
    find "$current_dir" -maxdepth 1 -mindepth 1 -type f -o -type d -exec file --mime-type {} + | grep "$type" | awk -F: '\''{print $1}'\'' | xargs -r ls --color=always -lt --time=ctime;
    
    echo; 
  done 
}; _list_by_type' 

 

 


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
