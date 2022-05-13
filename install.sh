#!/bin/bash

has_command () {
    if ! command -v $1 &> /dev/null
    then
        return -1
    fi
    return 0

}
system_install () {
    [ has_command brew ] && brew install $1 && return 0
    [ has_command apt ] && apt install $1 && return 0
    echo "Couldn't install $1, neither apt nor brew in \$PATH"
    return -1
}

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
npm install -g typescript typescript-language-server eslint_d eslint

# syntax highlightning
system_install bat

# fast grep
system_install ripgrep

# smart find
system_install fd

# better git diff
system_install git-delta

# rust-analyzer
rustup component add rust-src
system_install rust-analyzer
