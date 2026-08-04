# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH:/Applications/Docker.app/Contents/Resources/bin"
# Silence direnv's startup chatter — its output during zsh init leaves a stale
# p10k instant prompt above the real one in tmux-resurrect'd panes.
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git z fzf zsh-autosuggestions zsh-syntax-highlighting colored-man-pages extract)
source "$ZSH/oh-my-zsh.sh"

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

# Environment Vars
export NVM_DIR="$HOME/.nvm"
# Lazy nvm: sourcing nvm.sh costs ~1s per shell, so put the default node's bin
# on PATH directly and only load the real nvm on first `nvm` invocation.
_load_nvm() {
  unfunction nvm 2>/dev/null
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
nvm() { _load_nvm && nvm "$@" }
_nvm_default="$(cat "$NVM_DIR/alias/default" 2>/dev/null)"
if [[ ! -d "$NVM_DIR/versions/node/$_nvm_default" ]]; then
  # default is a built-in alias like "node" (= latest installed version)
  _nvm_vers=("$NVM_DIR"/versions/node/*(N/n))
  (( ${#_nvm_vers} )) && _nvm_default="${_nvm_vers[-1]:t}"
fi
if [[ -d "$NVM_DIR/versions/node/$_nvm_default/bin" ]]; then
  export PATH="$NVM_DIR/versions/node/$_nvm_default/bin:$PATH"
else
  _load_nvm  # couldn't resolve a default node — fall back to eager load
fi
unset _nvm_default _nvm_vers
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# go
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable VI shortcuts on CLI
bindkey -v
# avoid the annoying backspace/delete issue 
# where backspace stops deleting characters
bindkey -v '^?' backward-delete-char

# Show the full typed command in the tmux pane title (border shows #{pane_title})
DISABLE_AUTO_TITLE=true                      # stop oh-my-zsh from setting its own title
autoload -Uz add-zsh-hook
_tmux_title_preexec() { print -rn $'\e]2;'"$1"$'\e\\' }                       # the line you typed
_tmux_title_precmd()  { print -rn $'\e]2;'"zsh: ${PWD/#$HOME/~}"$'\e\\' }     # reset to cwd when idle
add-zsh-hook preexec _tmux_title_preexec
add-zsh-hook precmd  _tmux_title_precmd

# Work/machine-specific config (corporate CA bundles, employer aliases, etc.)
# lives in ~/.zshrc.local, which is deliberately not tracked in this repo.
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
