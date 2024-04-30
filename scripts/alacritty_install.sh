#!/bin/bash
# make needed drectories
mkdir -p ~/.config/alacritty ~/.config/alacritty/themes 
# Install Alacritty themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes/
# set up alacritty copnfig file
cp alacritty.toml ~/.config/alacritty/


# Clone the Alacritty source code
git clone https://github.com/alacritty/alacritty.git
cd alacritty

# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# Update Rust
rustup override set stable
rustup update stable

# Install dependencies
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc -y

# Build Alacritty
cargo build --release

# Install Alacritty terminfo
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Check install
infocmp alacritty
if [ $? -eq 0 ]; then
    echo "\nAlacritty ternminfo successfully installed\n"
else
    echo "FAIL"
fi

# Copy Alacritty binary to /usr/local/bin
sudo cp target/release/alacritty /usr/local/bin

# Copy Alacritty icon
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg

# Install desktop entry
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Set up manual pages
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null

# Set up shell completion for zsh
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
echo "Alacritty installation complete"
