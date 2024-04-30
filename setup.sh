#!/bin/bash
echo " Additional packages install"
scipts/additional_packages.sh

echo "*******Install Alacritty*******"
scripts/alacritty_install.sh

echo "*******Install Spotify*******"
scripts/spotify_install.sh

echo "*******SHELL SETUP*******"
scripts/zsh_install.sh

# End of script
echo "Setup complete!"
