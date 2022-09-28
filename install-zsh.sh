#!/bin/sh

# OS release
OS=`cat /etc/os-release | grep ^ID= | awk -F"=" '{print $2}'`
#echo $OS

ZSH_CUSTOM=~/.oh-my-zsh/custom

# Package manager
if [ $OS = "ubuntu" ] ; then
    PKG=apt
else
    PKG=yum
fi
#echo $PKG

# oh-my-zsh install
sudo $PKG install -y zsh git
sudo echo /usr/bin/zsh >> /etc/shells
sudo chsh -s /usr/bin/zsh
sudo echo ‘Y’ | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' $PWD/.zshrc
sudo sed -i -e '27 s/# //g' $PWD/.zshrc
sudo sed -i -e 's/#\ HIST_STAMPS=\"mm\/dd\/yyyy\"/HIST_STAMPS=\"%m\/%d\/%y\ %T"/g' $PWD/.zshrc
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo echo -e 'source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh' >> $PWD/.zshrc
