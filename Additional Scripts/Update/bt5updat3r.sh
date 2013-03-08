#!bin/bash
echo "******************************************************************";
echo "*          WeLcOmE tO n1tr0g3n's bt5updat3 ScRiPt v1.1           *";
echo "*                                                                *";
echo "*            FeEl FrEe To EdIt ThIs FiLe As YoU wIsH             *";
echo "*                      ┌∩┐(◣_◢)┌∩┐                               *";
echo "*    Visit www.Top-hat-Sec.com/forum & wwww.n1tr0g3n.com         *";
echo "******************************************************************";
echo ""
sleep 6
echo ""
echo 
echo
read -p "Press enter to continue if you would like to update your BT5 install"
echo	
echo
echo
#These are the extra tools I have included to automatically install and update
#if installed already;
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install figlet
sudo apt-get install terminator
sudo apt-get install gtk-recordmydesktop
sudo apt-get install smplayer
sudo apt-get install bleachbit
sudo apt-get install synaptic
sudo airodump-ng-oui-update
echo	
echo
echo
echo
read -p "Now it's time to update your SVN's in the Pentest folder, this may take a while. Hit enter to continue"
echo
echo
echo
echo
echo
# This will update all Tools in your /Pentest Folder using their SVN
sudo xterm -hold -e "find /pentest/ -maxdepth 5 -type d -name ".svn" -type d -ls -exec svn update {}/.. \;"
echo
echo
echo
echo
echo                                            " ┌∩┐(◣_◢)┌∩┐ "
echo                                           "www.n1tr0g3n.com"
