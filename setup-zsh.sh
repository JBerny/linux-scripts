#!/bin/bash

OSRELEASE=$(sudo cat /proc/version)
UBUNTU=$(echo "$OSRELEASE"| grep -i "ubuntu" )
if test ! $UBUNTU ; then
  echo "This script can only run for Ubuntu"
  exit 1
fi 

# Install zsh
sudo apt-get install zsh

chsh -s $(which zsh)

sudo apt-get install powerline fonts-powerline

# Install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change theme
#cat ~/.zshrc | sed 's/ZSH_THEME=.*/ZSH_THEME="agnoster"/' > ~/.zshrc


# Setup profiles
function append_source_file {
  echo """
if [ -f ~/$1 ]; then
  source ~/$1
fi

""" >> $2
}

FILES=""".bash_aliases
.bash_env
"""

echo "Creating profile files"
for file in $FILES ; do
  touch ~/$file
  append_source_file $file ~/.bash_profile
  append_source_file $file ~/.zshrc
done


