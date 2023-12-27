# Dots

A quick way to get set up after a fresh install.

The script setup.sh will install alacritty and zsh with the needed plugins, fonts and themes to get back up to speed. 


Term: Alacritty

Shell: Zsh

Oh-my-zsh : https://github.com/ohmyzsh/ohmyzsh
    

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Powerlevel10k: https://github.com/romkatv/powerlevel10k#oh-my-zsh

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

Themes: https://github.com/alacritty/alacritty-theme

    mkdir -p ~/.config/alacritty/themes
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

zsh-autocomplete: https://github.com/marlonrichert/zsh-autocomplete
  git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete


zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

    git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
