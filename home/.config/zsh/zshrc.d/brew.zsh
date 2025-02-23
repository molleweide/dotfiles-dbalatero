# https://docs.brew.sh/Manpage#environment
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
alias bcu="brew cu"
alias brewup="brew update && brew upgrade"
alias caskup="brew cu -af"

arch="$(get-arch)"
# /opt/homebrew
# eval $(/opt/homebrew/bin/brew shellenv)
if is-mac; then
	if test "$arch" = 'a64'; then
        export HOMEBREW_PREFIX="/opt/homebrew";
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
        export HOMEBREW_REPOSITORY="/opt/homebrew";
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
        export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
        export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
	fi
fi
