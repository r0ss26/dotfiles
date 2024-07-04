
export PATH=$HOME/bin:/usr/local/bin:$PATH:/Applications/Docker.app/Contents/Resources/bin/:/opt/homebrew/bin
eval "$(direnv hook zsh)"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Load Aliases
if [ -f ~/dotfiles/zsh/aliases/.aliases ]; then
    source ~/dotfiles/zsh/aliases/.aliases
else
    print "404: ~/dotfiles/zsh/aliases/.aliases"
fi

# Load Deputy Aliases
if [ -f ~/.deputy-aliases ]; then
    source ~/.deputy-aliases
else
    print "404: ~/.deputy-aliases not found."
fi

# Environment Vars
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/dev
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# config
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
