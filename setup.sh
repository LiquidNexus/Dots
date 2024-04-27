#!/bin/bash

# Function to detect package manager and install packages
install_package() {
    if command -v apt-get > /dev/null; then
        sudo apt-get update
        sudo apt-get install -y "$@"
    elif command -v dnf > /dev/null; then
        sudo dnf install -y "$@"
    elif command -v yum > /dev/null; then
        sudo yum install -y "$@"
    elif command -v pacman > /dev/null; then
        sudo pacman -Syu --noconfirm "$@"
    else
        echo "Unsupported package manager. Install packages manually."
        return 1
    fi
}

# Identify the distribution
distro=$(grep ^ID= /etc/os-release | cut -d '=' -f 2)

# Install Alacritty and Zsh
install_package alacritty zsh

#Install Spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg\n
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

echo "*******SHELL SETUP*******"
# Change default shell to Zsh
chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone Zsh plugins
git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Copy .zshrc from the current directory
cp .zshrc .zsh_alias $HOME/

# Create necessary directories
mkdir -p ~/.config/alacritty ~/.config/alacritty/themes ~/.local/share/fonts
echo "*******ALACRITTY SETUP*******"
# Copy Alacritty config from the current directory (assuming script is in the root of the cloned repo)
cp alacritty.toml ~/.config/alacritty/

# Install Alacritty themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes/

# Download and install Powerlevel10k fonts
curl -L -o ~/.local/share/fonts/MesloLGS_NF_Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -L -o ~/.local/share/fonts/MesloLGS_NF_Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -L -o ~/.local/share/fonts/MesloLGS_NF_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -L -o ~/.local/share/fonts/MesloLGS_NF_Bold_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Update font cache
fc-cache -f -v

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy Powerlevel10k theme config from the current directory
cp .p10k.zsh ~/

# End of script
echo "Setup complete!"
