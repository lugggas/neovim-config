#!/bin/bash

PROJECT_FOLDER=$(cd `dirname $0` && pwd)

has_command () {
    if ! command -v $1 &> /dev/null
    then
        return -1
    fi
    return 0

}

set_up_links () {
    mkdir -p $HOME/.config/nvim/
    ln -nfs $PROJECT_FOLDER/init.lua $HOME/.config/nvim/init.lua
    ln -nfs $PROJECT_FOLDER/lua $HOME/.config/nvim/lua
    ln -nfs $PROJECT_FOLDER/coc-settings.json $HOME/.config/nvim/coc-settings.json
}

set_up_links
has_command apt && sudo apt update

# install nvim
has_command brew && brew install neovim
if has_command apt; then
    curl -LO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
    sudo apt install ./nvim-linux64.deb
    rm -f ./nvim-linux64.deb
fi

# install nerd fonts
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
else
    if [[ ! -d nerd-fonts ]]; then
	    git clone https://github.com/ryanoasis/nerd-fonts.git
        cd nerd-fonts
        ./install.sh
        cd -
    fi
fi

# install node-js
if ! has_command npm; then
    if has_command apt; then
        # Using Ubuntu
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        apt install -y nodejs
    fi
    has_command brew && brew install node
fi

# install typescript
npm install -g typescript typescript-language-server vscode-langservers-extracted
# syntax highlightning
has_command brew && brew install bat
has_command apt && sudo apt install bat -y

# fast grep
has_command brew && brew install ripgrep
has_command apt && sudo apt install ripgrep -y

# smart find
has_command brew && brew install fd
has_command apt && sudo apt install fd-find -y


# install rustup
if ! has_command rustup; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# better git diff
cargo install --list | grep git-delta &> /dev/null && cargo install git-delta

# rust-analyzer
rustup component add rust-src
if has_command brew; then
    brew install rust-analyzer
else
    mkdir -p ~/.local/bin
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
fi

# clangd the c++ language server
has_command brew && brew install llvm
has_command apt && sudo apt install clangd-12 -y

# cmake for cmake projects
has_command brew && brew install cmake
has_command apt && sudo apt install cmake -y

# haskell
if ! has_command ghcup; then
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi
ghcup install hls
