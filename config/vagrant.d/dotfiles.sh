#!/bin/bash

git clone https://www.github.com/pacebl/dotfiles.git /home/vagrant/.dotfiles
/home/vagrant/.dotfiles/install-oh-my-zsh.sh
mv /home/vagrant/.zshrc /home/vagrant/.zshrc.ohmyzsh
/home/vagrant/.dotfiles/bootstrap.sh
