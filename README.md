# Setup Script for a new Debian based Systems

This setup script automates the process of configuring a new Debian-based system by installing and configuring Alacritty, ZSH,and isntalling apps such as spotify and brave.

## Usage

1. Clone this repository onto your Debian-based system:

    ```bash
    git clone https://github.com/LiquidNexus/Dots.git
    ```

2. Navigate into the cloned directory:

    ```bash
    cd Dots
    ```

3. Make the setup script executable:

    ```bash
    chmod +x setup.sh
    ```

4. Run the setup script:

    ```bash
    ./setup.sh
    ```

5. Follow the prompts and input any required information during the setup process.

## Major Components

### 1. Alacritty Installation
- Installs the Alacritty terminal emulator and sets up themes.
- Configures the Alacritty config file for personalized settings.

### 2. Zsh Shell Setup
- Installs the Zsh shell and configures it with the powerlevel10k theme.
- Sets up oh-my-zsh framework for enhanced shell functionalities.

### 3. Additional Packages
- Installs additional packages such as Spotify and Brave browser.
- Enhances system functionality with popular third-party applications.

## Notes

- Ensure that your system has internet access during the setup process to download dependencies.
- Make sure to review and adjust the scripts according to your system's requirements and preferences.

