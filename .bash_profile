if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# bash-completion
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

source $BASH_COMPLETION_COMPAT_DIR/git-completion.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gsajith/google-cloud-sdk/path.bash.inc' ]; then . '/Users/gsajith/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gsajith/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/gsajith/google-cloud-sdk/completion.bash.inc'; fi

GOOGLE_APPLICATION_CREDENTIALS="/Users/gsajith/grow-content/GrowContent-526aa498c03d.json"

alias fix='eslint . --fix; echo "ESLint fix done."'
