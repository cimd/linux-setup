# Configurations
alias dotf="cd $DOTFILES && $EDITOR $DOTFILES"

# Directories
alias drive="cd ~/Google\ Drive"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias gh="cd ~/Documents/GitHub"

# Laravel, php
alias a="php artisan"
alias fresh="php artisan migrate:fresh --seed"
alias routes="php artisan route:list"
alias cr="composer require"
alias ci="composer install"
alias cu="composer update"
alias cda="composer dump-autoload -o"
alias p="phpunit"
alias pstop="phpunit --order-by=defects --stop-on-failure"
alias pfilter="phpunit --filter"

# Npm, Yarn, Pnpm
alias ni="npm install"
alias nr="npm run"
alias w="npm run watch"
alias hot="npm run hot"
alias pn="pnpm"
alias pni="pnpm install"

# Git
alias g="git"
alias gs="git status"
alias gco="git checkout"
alias gb="git checkout -b"
alias m="git checkout main && git pull"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias nah="git reset --hard && git clean -df"
alias push="git push"
alias pull="git pull --rebase"

# List (basic, all, directories)
alias ll="ls -lh"
alias la="ls -lah"
alias lsd="ls -lh | grep --color=never '^d'"

# Command manipulations
alias h="history | tail -10"
alias copy="tr -d '\n' | pbcopy"
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias map="xargs -n1"
alias sudo='sudo ' # Enable aliases to be sudo’ed
alias mux='tmuxinator'
alias close='tmux detach-client'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias bundle="brew bundle --file=\"$DOTFILES/Brewfile\""

# Quick functions
alias reload="exec ${SHELL} -l"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias prunenodemodules="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"

# HTTP request helpers
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "${method}"="lwp-request -m '${method}'"
done

# Miscellaneous getters
alias week='date +%V'
alias path='echo -e ${PATH//:/\\n}'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep 'inet ' | grep -Fv 127.0.0.1 | awk '{print \$2}'"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Metaplex
alias mplp="pnpm programs:build && pnpm generate && pnpm validator"
alias mplc="pnpm build && pnpm test"
