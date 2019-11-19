# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ohnosay from Collin McMillen
FORTUNE_SHORT="$(fortune -s|tr '\n' ' ')"
FORTUNE_TRIMMED="$(echo ${FORTUNE_SHORT})"
python ~/.ohnosay.py "${FORTUNE_TRIMMED}"

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

alias ls="ls -a"

# 'ls' automatically when running cd
cd() {
    builtin cd "$@" && ls -a
}

# Placeholder LSCOLORS for mac
export LSCOLORS='Bxfxcxdxbxegadabagacad'

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

function __getRandomFace {
	FILE=~/.kaomoji.txt

	# get line count for $FILE (simulate 'wc -l')
	lc=0
	while read -r face; do
 	  ((lc++))
	done < $FILE

	# get a random number between 1 and $lc
	rnd=$RANDOM
	let "rnd %= $lc"
	((rnd++))

	# traverse file and find line number $rnd
	i=0
	while read -r face; do
	 ((i++))
	 [ $i -eq $rnd ] && break
	done < $FILE

	# output random line
	# echo $line 
}

function __getRandomLine {
	FILE=~/.sparkles.txt

	# get line count for $FILE (simulate 'wc -l')
	lc=0
	while read -r line; do
 	  ((lc++))
	done < $FILE

	# get a random number between 1 and $lc
	rnd=$RANDOM
	let "rnd %= $lc"
	((rnd++))

	# traverse file and find line number $rnd
	i=0
	while read -r line; do
	 ((i++))
	 [ $i -eq $rnd ] && break
	done < $FILE

	# output random line
	# echo $line 
}


#######################################################
# Set the ultimate amazing command prompt
#######################################################

function __setprompt
{
	local LAST_COMMAND=$? # Must come first!

	# Define colors
	local LIGHTGRAY="\033[0;37m"
	local WHITE="\033[1;37m"
	local BLACK="\033[0;30m"
	local DARKGRAY="\033[1;30m"
	local RED="\033[1;38;5;130m"
	local LIGHTRED="\033[1;31m"
	local GREEN="\033[0;38;5;37m"
	local LIGHTGREEN="\033[1;32m"
	local BROWN="\033[0;38;5;179m"
	local YELLOW="\033[1;33m"
	local BLUE="\033[0;34m"
	local LIGHTBLUE="\033[1;34m"
	local MAGENTA="\033[0;35m"
	local LIGHTMAGENTA="\033[1;35m"
	local CYAN="\033[0;38;5;32m"
	local LIGHTCYAN="\033[1;36m"
	local PINK="\033[0;38;5;219m"
	local GRAY="\033[0;38;5;239m"
	local NOCOLOR="\033[0m"

	# Show error exit code if there is one
	if [[ $LAST_COMMAND != 0 ]]; then
		# PS1="\[${RED}\](\[${LIGHTRED}\]ERROR\[${RED}\])-(\[${LIGHTRED}\]Exit Code \[${WHITE}\]${LAST_COMMAND}\[${RED}\])-(\[${LIGHTRED}\]"
		# PS1="\[${LIGHTGRAY}\]\n(\[${LIGHTRED}\]ERROR\[${LIGHTGRAY}\])-(\[${RED}\]Exit Code \[${LIGHTRED}\]${LAST_COMMAND}\[${LIGHTGRAY}\])-(\[${RED}\]"
		PS1="\[${LIGHTGRAY}\]\n❴\[${LIGHTRED}\]ERROR\[${LIGHTGRAY}\] ⥤ \[${RED}\]Exit Code \[${LIGHTRED}\]${LAST_COMMAND}\[${LIGHTGRAY}\]: \[${RED}\]"
		if [[ $LAST_COMMAND == 1 ]]; then
			PS1+="General error"
		elif [ $LAST_COMMAND == 2 ]; then
			PS1+="Missing keyword, command, or permission problem"
		elif [ $LAST_COMMAND == 126 ]; then
			PS1+="Permission problem or command is not an executable"
		elif [ $LAST_COMMAND == 127 ]; then
			PS1+="Command not found"
		elif [ $LAST_COMMAND == 128 ]; then
			PS1+="Invalid argument to exit"
		elif [ $LAST_COMMAND == 129 ]; then
			PS1+="Fatal error signal 1"
		elif [ $LAST_COMMAND == 130 ]; then
			PS1+="Script terminated by Control-C"
		elif [ $LAST_COMMAND == 131 ]; then
			PS1+="Fatal error signal 3"
		elif [ $LAST_COMMAND == 132 ]; then
			PS1+="Fatal error signal 4"
		elif [ $LAST_COMMAND == 133 ]; then
			PS1+="Fatal error signal 5"
		elif [ $LAST_COMMAND == 134 ]; then
			PS1+="Fatal error signal 6"
		elif [ $LAST_COMMAND == 135 ]; then
			PS1+="Fatal error signal 7"
		elif [ $LAST_COMMAND == 136 ]; then
			PS1+="Fatal error signal 8"
		elif [ $LAST_COMMAND == 137 ]; then
			PS1+="Fatal error signal 9"
		elif [ $LAST_COMMAND -gt 255 ]; then
			PS1+="Exit status out of range"
		else
			PS1+="Unknown error code"
		fi
		# PS1+="\[${LIGHTGRAY}\])\[${NOCOLOR}\]\n"
		PS1+="\[${LIGHTGRAY}\] ❵\[${NOCOLOR}\]\n"
	else
		PS1="\n"
	fi

	# Date
	PS1+="\[${LIGHTGRAY}\][\[${CYAN}\]\$(date +%a) $(date +%b-'%-m')" # Date
	PS1+="${PINK} $(date +'%-I':%M:%S%p)\[${LIGHTGRAY}\]]⁙" # Time

	# Jobs
	#PS1+="\[${LIGHTGRAY}\]:\[${MAGENTA}\]\j"

	#PS1+="\[${LIGHTGRAY}\])-"

	# User and server
	local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
	local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
	if [ $SSH2_IP ] || [ $SSH_IP ] ; then
		PS1+="(\[${RED}\]\u@\h"
	else
		PS1+="(\[${RED}\]\u"
	fi

	# Current directory
	PS1+="\[${LIGHTGRAY}\]:\[${BROWN}\]\w\[${LIGHTGRAY}\])"

	__getRandomLine
	PS1+="\[${GRAY}\] $line "
	
	__getRandomFace
	PS1+="\[${WHITE}\] $face "
	
	REVERSED_LINE="$(echo $line | rev)"
	PS1+="\[${GRAY}\] $REVERSED_LINE"

	#PS1+="--"

	# Total size of files in current directory
	#PS1+="(\[${GREEN}\]$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')\[${LIGHTGRAY}\]:"

	# Number of files
	#PS1+="\[${GREEN}\]\$(/bin/ls -A -1 | /usr/bin/wc -l)\[${LIGHTGRAY}\])"

	# Skip to the next line
	PS1+="\n"

	if [[ $EUID -ne 0 ]]; then
		PS1+="\[${GREEN}\]⤜⤘ ✨\[${NOCOLOR}\] " # Normal user
	else
		PS1+="\[${RED}\]⤜(super)⤜⤘ 🔥\[${NOCOLOR}\] " # Root user
	fi

	# PS2 is used to continue a command using the \ character
	PS2="\[${GREEN}\]>\[${NOCOLOR}\] "

	# PS3 is used to enter a number choice in a script
	PS3='Please enter a number from above list: '

	# PS4 is used for tracing a script in debug mode
	PS4='\[${LIGHTGRAY}\]+\[${NOCOLOR}\] '
}
PROMPT_COMMAND='__setprompt'
