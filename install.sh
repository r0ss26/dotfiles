#!/bin/bash

# Run symlink script
./symlinks.sh

# Install Powerlevel10k if not installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Install AWS CodeWhisperer CLI
./aws/codewhisperer/install.sh

# Source the new zsh configuration
source ~/.zshrc

echo "Dotfiles installation complete!"
