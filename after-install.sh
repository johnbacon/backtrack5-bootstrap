#!/bin/sh
echo -e "\e[31mBack|Track 5r3\e[0m Post-Install Script"
SCRIPTPATH=`pwd`
echo
echo "Deleting the install icon..."
rm -f /root/Desktop/backtrack-install.desktop
#cd ~
#echo
#echo "Getting my VIM just the way I like it..."
#git clone git://github.com/johnbacon/dotfiles.git
#mv vim/vimrc .vimrc
#mv vim .vim
cd $SCRIPTPATH
#echo
#echo -e "Installing \e[33mGuake\e[0m &amp; \e[33mTilda\e[0m..."
#apt-get install guake tilda -y
echo
echo -e "Getting \e[32mTor\e[0m..."
sh get-tor.sh
#echo
#echo -e "Getting \e[36mDropbox\e[0m..."
#sh get-dropbox.sh
echo
echo "Getting SRware Iron..."
sh get-iron-browser.sh
cd $SCRIPTPATH
echo
echo -e "Getting \e[33mscripts\e[0m..."
sh get-scripts.sh
echo
echo "Cleaning up..."
apt-get autoremove -y &amp;&amp; apt-get clean
#echo
#echo -e "Getting \e[33mwordlists\e[0m..."
#sh get-wordlists.sh &amp; # this takes forever
echo
echo -e "Updating \e[31mBack|Track\e[0m..."
python /pentest/bt5up/bt5up.py
echo
echo -e "\e[32mDONE\e[0m"