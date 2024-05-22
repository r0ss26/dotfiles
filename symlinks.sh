# !/bin/bash

# Function to create a symlink and handle errors
create_symlink() {
    local source_file=$1
    local target_file=$2

    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "Error: $target_file already exists and is not a symlink. Please move or remove it manually."
        return 1
    elif [ -L "$target_file" ]; then
        echo "Updating symlink: $target_file"
        ln -sf "$source_file" "$target_file"
    else
        echo "Creating symlink: $target_file"
        ln -s "$source_file" "$target_file"
    fi

    if [ $? -eq 0 ]; then
        echo "Symlink created: $source_file -> $target_file"
    else
        echo "Failed to create symlink: $source_file -> $target_file"
    fi
}

# Create symlinks for zsh configuration
create_symlink "$(pwd)/zsh/.zshrc" "$HOME/.zshrc"
create_symlink "$(pwd)/zsh/powerlevel10k/.p10k.zsh" "$HOME/.p10k.zsh"

# Add other symlinks as needed
# create_symlink "$(pwd)/vim/.vimrc" "$HOME/.vimrc"
# ln -sf "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf

echo "Symlinks setup complete!"

