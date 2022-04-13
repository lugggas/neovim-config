#!/bin/bash

# install nerd fonts
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
else
    git clone https://github.com/ryanoasis/nerd-fonts.git
    cd nerd-fonts
    ./install.sh
fi

# install typescript
npm install -g typescript typescript-language-server eslint_d

# syntax highlightning
brew install bat

# fast grep
brew install ripgrep

# smart find
brew install fd

# better git diff
brew install git-delta

# rust-analyzer
rustup component add rust-src
brew install rust-analyzer
