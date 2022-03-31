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
