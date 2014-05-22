#!/bin/bash

apt-get update
apt-get install -y git git-core vim zsh
chsh -s `which zsh` vagrant
