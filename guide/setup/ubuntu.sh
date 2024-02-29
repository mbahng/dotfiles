#!/bin/bash

# set up minimal install so you don't have bloat 

# first update and upgrade whatever packages
sudo apt update && sudo apt upgrade -y 

# get rid of nautilus file manager and replace it with nemo 
sudo apt install nemo -y && sudo apt remove nautilus -y 

sudo apt install htop nvtop git ssh cmatrix neovim -y

sudo apt install flameshot zathura 

sudo apt install firefox spotify-client -y 
