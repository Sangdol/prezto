#
# Easier navigation: .., ..., ...., ....., ~ and -
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

#
# Shortcuts
#
alias t="cd ~/temp"
alias dl="cd ~/Downloads"
alias h="history"
alias vi='vim'
alias oo='open .'

#
# functions
#

# Python server
serve() {
    local port=${1:-8080}
    python -m SimpleHTTPServer $port > /dev/null 2>&1 &
    open http://localhost:$port
}
