#!/bin/bash

# Function to check command success
# Function to check command success
check_command() {
    if [ $? -ne 0 ]; then
        read -p "The last command failed. Do you want to try again? [y/n]: " choice
        case "$choice" in
          y|Y ) return 1 ;;
          n|N ) exit 1 ;;
          * ) echo "Invalid input. Please enter y or n." && return 1 ;;
        esac
    fi
    return 0
}

# Function to install Alacritty
install_alacritty() {
    echo "${FMT_BLUE}*******Install Alacritty*******${FMT_RESET}"
    # Make necessary directories
    mkdir -p ~/.config/alacritty/themes 

    # Clone Alacritty theme repository
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes/
    
    # Set up Alacritty config file
    cp configs/alacritty.toml ~/.config/alacritty/

    # Install Rust using rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"

    # Update Rust
    rustup override set stable
    rustup update stable

    # Clone Alacritty source code
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty || exit
   
    # Install dependencies
    sudo apt update 
    sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc curl -y
    check_command

    # Build Alacritty
    cargo build --release
    check_command

    # Install Alacritty terminfo
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    check_command

    # Copy Alacritty binary to /usr/local/bin
    sudo cp target/release/alacritty /usr/local/bin
    check_command

    # Copy Alacritty icon
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg

    # Install desktop entry
    sudo desktop-file-install extra/linux/Alacritty.desktop
    check_command

    # Set up manual pages
    sudo mkdir -p /usr/local/share/man/man1
    sudo mkdir -p /usr/local/share/man/man5
    scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
    scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
    scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
    scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
    check_command

    # Set up shell completion for zsh
    mkdir -p ${ZDOTDIR:-~}/.zsh_functions
    echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
    cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
    check_command

    echo "Alacritty installation complete"
}

# Function to install Zsh
install_zsh() {
    echo "${FMT_BLUE}*******SHELL SETUP*******${FMT_RESET}"
    # Install Zsh package
    sudo apt install zsh-autosuggestions zsh-syntax-highlighting zsh -y
    check_command
    
    # Install powerlevel10k fonts
    mkdir -p ~/.local/share/fonts
    curl -L -o ~/.local/share/fonts/MesloLGS_NF_Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -L -o ~/.local/share/fonts/MesloLGS_NF_Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -L -o ~/.local/share/fonts/MesloLGS_NF_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -L -o ~/.local/share/fonts/MesloLGS_NF_Bold_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    fc-cache -f -v
    check_command

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
 
    # Install powerlevel10k theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    check_command
    # Install autosuggestions 
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # Install zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # Install zsh-fast-syntax-highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # Isntall zsh-auto-complete
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
    
    # Copy configuration files
    cp "$HOME/Dots/configs/.zshrc" $HOME
    check_command
    cp "$HOME/Dots/configs/.zsh_alias" $HOME
    check_command
    cp "$HOME/Dots/configs/.p10k.zsh" $HOME
    check_command
}

# Function to install additional packages
install_additional_packages() {
    echo "${FMT_BLUE}*******Install additional packages*******${FMT_RESET}"
    # Install Spotify
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client -y
    check_command

    # Install Brave browser
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
    check_command
    # Install vim
    sudo apt install vim -y
    cp "$HOME/Dots/configs/.vimrc" $HOME
}

# Run setup steps
install_alacritty
install_zsh
install_additional_packages

echo "Setup complete!"
