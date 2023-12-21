# Dots
A quick way to get set up up after a fresh install

Term: Alacritty

Shell: Zsh

Oh-my-zsh : https://github.com/ohmyzsh/ohmyzsh
    

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Powerlevel10k: https://github.com/romkatv/powerlevel10k#oh-my-zsh

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

Themes: https://github.com/alacritty/alacritty-theme

    mkdir -p ~/.config/alacritty/themes
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions

    git clone git@github.com:zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

    git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
