#!/usr/bin/python
# Finalized on 12/24/2012
# Backtrack 5 Uodate Script written by n1tr0g3n & www.n1tr0g3n.com

import sys, os, time, urllib2

print '\n\n\n\n'
print ("n1tr0g3n's Backtrack 5 Update Script")
time.sleep (3.0)

os.system('clear')

print '\n\n\n\n'

# Checking for internet connectivity:

print ("Checking internet activity")
time.sleep (3.0)
try:
	con = urllib2.urlopen('http://www.google.com/')
	data = con.read()
	print 'Checking for internet connectivity please wait ...'
	print 'Internet connectivity ... OK!'
	print 'Starting update script!'
except:
	print 'No internet :('
	sys.exit()

os.system('clear')

print '\n\n\n'
	
print ("Now running all system updates")
time.sleep (3.0)
os.system('sudo apt-get update -y && sudo apt-get upgrade -y sudo apt-get dist-upgrade -y')

os.system('clear')

print '\n\n\n'

# Below are tools that will be installed#

# This will install Gnome-Tweak-Tool

os.system('sudo add-apt-repository ppa:tualatrix/ppa &')

os.system('sudo apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y')
os.system('clear')

os.system('sudo apt-get install ubuntu-tweak -y')
os.system('clear')

# This will install Vlc Player & Mozilla Plugin
os.system('sudo apt-get install vlc vlc-plugin-pulse mozilla-plugin-vlc -y')
os.system('clear')

# This will remove the annoying Mail icon "only" from the menu bar
os.system('sudo apt-get remove indicator-me indicator-messages -y')
os.system('clear')

# This will install Software-Center     
os.system('sudo apt-get install software-center -y')
os.system('clear')

# This will install update manager to run Ubuntu updates
os.system('sudo apt-get install update-manager -y')
os.system('clear')

# This will install Update Manager
os.system('sudo apt-get install update-manager -y')
os.system('clear')

# this will install Gdebi package installer
os.system('sudo apt-get install gdebi -y')
os.system('clear')

# this ill install Synaptic Package Manager
os.system('sudo apt-get install synaptic -y')
os.system('clear')

# This will install Nautilus right click open in terminal
os.system('sudo apt-get install nautilus-open-terminal -y')
os.system('clear')

#This will install Smplayer
os.system('sudo apt-get install smplayer -y')
os.system('clear')

# this will install GTK- Record My desktop 
os.system('sudo apt-get install gtk-recordmydesktop -y')
os.system('clear')

# This will install Bleachbit Cleaner
os.system('sudo apt-get install bleachbit -y')
os.system('clear')

# this will install Archive Manager "File Roller"
os.system('sudo apt-get install file-roller -y')
os.system('clear')

# This will update aircrack-ng
os.system('sudo airodump-ng-oui-update')

os.system('clear')

print '\n\n\n'

print ("[+]Installing Looks Like XP Skins[+].....")
time.sleep (4.0)

os.system('cd /root/')

os.system('wget http://www.phillips321.co.uk/downloads/LookLikeXP.deb')

os.system ('sudo dpkg -i LookLikeXP.deb')

os.system('clear')

os.system('rm LookLikeXP.deb')

os.system('clear')

print '\n\n\n'

print("[+]Installing SSLstrip[+]......")

time.sleep (4.0)

os.system ('cd /pentest/web/sslstrip')

os.system('sudo python setup.py install')

os.system('clear')

print '\n\n\n'

print ("[+]Now running all system updates once again[+]")
time.sleep (3.0)
os.system('sudo apt-get update -y && sudo apt-get upgrade -y sudo apt-get dist-upgrade -y')

os.system('clear')

# This will update all SVN's in the pentest folder.

print("[+]Updating all SVN's in the pentest folder[+]......")
time.sleep (3.0)

os.system('find $pentest/ -maxdepth 5 -type d -name ".svn" -type d -ls -exec svn update {}/.. \;')

os.system('clear')

print '\n\n\n'

# This will remove software no longer needed after updates

print("[+]Removing old un needed software now[+]......")
time.sleep (3.0)

os.system('sudo apt-get autoremove -y')

os.system('clear')

print '\n\n\n'

print("Please log off and back on for certain installs to take effect like Remove mail icon and Nautilus Open Terminal")

time.sleep (4.0)

print '\n\n\n'

sys.exit()
