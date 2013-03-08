#!/usr/bin/python
# This is a update script for Backtrack 5.
# Rewritten by: bl4ck5w4n aka MaXFX in BT Forum
# Mail: bl4ck5w4n5@gmail.com
# Blog: http://bl4ck5w4n.tk
# Original autor Sickness http://sickness.tor.hu (Coded in C)

import  os, time, inspect,sys,fileinput
import smtplib, getopt
from email.MIMEText import MIMEText
from time import gmtime, strftime


mods = '/pentest/bt5up/mods' # Path for the additional tools module

global tsleep 
tsleep = 2



if not os.geteuid()==0:
    sys.exit("\nYou must be root to run bt5up\n")


if os.path.isfile(mods+'tools.py'):
	sys.path.append(mods)
	
else:
   os.system('mkdir -p '+ mods)
   os.system('cd ' + mods + ' && wget http://bl4ck5w4n.tk/bt5up/mods/tools.py -c -q') 
   sys.path.append(mods)
   
import tools
   


def get_version():
      curversion = 1.6
      return curversion

def backtrack_update():
	print("\033[1;31m [>]\033[1;m Updating and cleaning Backtrack, please wait.")
	time.sleep(tsleep)

	if(os.system("apt-get update && apt-get -y dist-upgrade && apt-get autoremove -y && apt-get -y autoclean") == 0):
		print("\033[1;31m [>]\033[1;m Backtrack updated and cleaned successfully!")
		time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Backtrack.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Backtrack' >> /root/bt5up.log")
		time.sleep(tsleep)
	


def exploit_db():
        print("\033[1;31m [>]\033[1;m Updating Exploit-db, please wait.")
        time.sleep(tsleep)
        if(os.system("cd /pentest/exploits/exploitdb/platforms/ && svn up") == 0):
               	print("\033[1;31m [>]\033[1;m Exploit-db updated successfully!")
		time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Exploit-db.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Exploit-db' >> /root/bt5up.log")
		time.sleep(tsleep)
	



def Set():
        print("\033[1;31m [>]\033[1;m Updating SET, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/exploits/set/ && svn up") == 0):
	
	  print("\033[1;31m [>]\033[1;m SET updated successfully!")
	  time.sleep(tsleep)
	
	else:
	  print("\033[1;31m [>]\033[1;m Failed to update SET.")
	  os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update SET' >> /root/bt5up.log")
	  time.sleep(tsleep)
	


def warvox():
	print("\033[1;31m [>]\033[1;m Updating Warvox, please wait.")
	time.sleep(tsleep)
	
	if(os.system("cd /pentest/telephony/warvox/ && svn up") == 0):
	  
	      print("\033[1;31m [>]\033[1;m Warvox updated successfully!")
	      time.sleep(tsleep)
	
	else:
		if(os.system("rm -rf /pentest/telephony/warvox/ ; svn co http://www.metasploit.com/svn/warvox/trunk /pentest/telephony/warvox") == 0):
		      print("\033[1;31m [>]\033[1;m Warvox updated successfully!")
		      time.sleep(tsleep)		  
		else:		
		      print("\033[1;31m [>]\033[1;m Failed to update Warvox")
		      os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Warvox' >> /root/bt5up.log")
		      time.sleep(tsleep)
	


def aircrack():
	print("\033[1;31m [>]\033[1;m Updating Aircrack-NG and Airodump, please wait.")
	time.sleep(tsleep)
	
	if(os.system("cd /pentest/wireless/aircrack-ng/ && svn up") == 0):
	  os.system("cd /pentest/wireless/aircrack-ng/scripts/ && chmod a+x airodump-ng-oui-update && ./airodump-ng-oui-update")
	  os.system("cd /pentest/wireless/aircrack-ng/scripts/ && make && make install")
	  print("\033[1;31m [>]\033[1;m Aircrack-NG and Airodump updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Aircrack-ng.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Aircrack' >> /root/bt5up.log")
		time.sleep(tsleep)
	
def wifite():
        print("\033[1;31m [>]\033[1;m Updating WiFite, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/wireless/wifite/ && python wifite.py -upgrade") == 0):
	
	  print("\033[1;31m [>]\033[1;m WiFite updated successfully!")
	  time.sleep(tsleep)
	
	else:
	  print("\033[1;31m [>]\033[1;m Failed to update WiFite.")
	  os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update WiFite' >> /root/bt5up.log")
	  time.sleep(tsleep)

def fernwifi():
        print("\033[1;31m [>]\033[1;m Updating Fern Wifi Cracker, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/wireless/fern-wifi-cracker/ && svn update") == 0):
	
	  print("\033[1;31m [>]\033[1;m Fern Wifi Cracker updated successfully!")
	  time.sleep(tsleep)
	
	else:
	  print("\033[1;31m [>]\033[1;m Failed to update Fern Wifi Cracker.")
	  os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Fern Wifi Cracker' >> /root/bt5up.log")
	  time.sleep(tsleep)    
  
def dedected():
        print("\033[1;31m [>]\033[1;m Updating Dedected, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/telephony/dedected/ && svn update") == 0):
	
	  print("\033[1;31m [>]\033[1;m Dedected updated successfully!")
	  time.sleep(tsleep)
	
	else:
	  print("\033[1;31m [>]\033[1;m Failed to update Dedected.")
	  os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Dedected' >> /root/bt5up.log")
	  time.sleep(tsleep)

    
def giskismet():
	print("\033[1;31m [>]\033[1;m Updating Giskismet, please wait.")
	time.sleep(tsleep)
	
	if(os.system("cd /pentest/wireless/giskismet/ && svn up") == 0):
	  
	  print("\033[1;31m [>]\033[1;m Giskismet updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Giskismet.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Giskismet' >> /root/bt5up.log")
		time.sleep(tsleep)
	


def msf():
	print("\033[1;31m [>]\033[1;m Updating Metasploit, please wait.")
	time.sleep(tsleep)
	
	if(os.system("msfupdate") == 0):
	  os.system("ldconfig")
	  print("\033[1;31m [>]\033[1;m Metasploit updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Metasploit.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Metasploit' >> /root/bt5up.log")
		time.sleep(tsleep)
	
def openvas():

	print("\033[1;31m [>]\033[1;m Updating OpenVAS, please wait.")
	
        if (os.system("openvas-nvt-sync")== 0): 
	    print("\033[1;31m [>]\033[1;m OpenVAS updated successfully!")
	    time.sleep(tsleep)
        else: 
            print("\033[1;31m [>]\033[1;m Failed to update OpenVAS!")
            os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update OpenVAS' >> /root/bt5up.log")
            time.sleep(tsleep)


def nessus():
  if(os.system("which nessus > /dev/null") == 0):
	print("\033[1;31m [>]\033[1;m Updating Nessus plugins, please wait.")
	time.sleep(tsleep)
	
	if(os.system("cd /opt/nessus/sbin/ && ./nessus-update-plugins") == 0):
	  
	  print("\033[1;31m [>]\033[1;m Nessus plugins updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Nessus.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Nessus' >> /root/bt5up.log")
		time.sleep(tsleep)
  else:
      print("\033[1;31m [>]\033[1;m Nessus is not installed.")
      time.sleep(tsleep)


  
def hexorbase():
	print("\033[1;31m [>]\033[1;m Updating Hexorbase, please wait.")
	time.sleep(tsleep)
	
	if(os.system("cd /pentest/database/hexorbase/ && svn checkout http://hexorbase.googlecode.com/svn/") == 0):
	  
	      print("\033[1;31m [>]\033[1;m Hexorbase updated successfully!")
	      time.sleep(tsleep)
	else:
	      print("\033[1;31m [>]\033[1;m Failed to update HexorBase!")
	      os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update HexorBase' >> /root/bt5up.log")
	      time.sleep(tsleep)
      
def w3af():
        print("\033[1;31m [>]\033[1;m Updating W3AF, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/web/w3af/ && svn up") == 0):
	  
	  print("\033[1;31m [>]\033[1;m W3AF updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update W3AF.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update W3AF' >> /root/bt5up.log")
		time.sleep(tsleep)
	
def joomscan():
        print("\033[1;31m [>]\033[1;m Updating JoomScan, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/web/joomscan/ && perl joomscan.pl update") == 0):
	  
	  print("\033[1;31m [>]\033[1;m JoomScan updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update JoomScan.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update JoomScan' >> /root/bt5up.log")
		time.sleep(tsleep)

def wpscan():
        print("\033[1;31m [>]\033[1;m Updating WPScan, please wait.")
        time.sleep(tsleep)
        
        if os.path.isdir('/pentest/web/wpscan/.svn'):
	    os.system('rm -Rf /pentest/web/wpscan')
	    os.system('apt-get install libcurl4-gnutls-dev libopenssl-ruby libxml2 libxml2-dev libxslt1-dev')
	    os.system('cd /pentest/web/ && git clone https://github.com/wpscanteam/wpscan.git')
	    os.system('cd /pentest/web/wpscan && gem install bundler && bundle install && gem install typhoeus -v 0.4.2')
	    print("\033[1;31m [>]\033[1;m WPScan  updated successfully!")
	    time.sleep(tsleep)
	else:
	    os.system('cd /pentest/web/wpscan && ruby wpscan.rb --update')
	    print("\033[1;31m [>]\033[1;m WPScan  updated successfully!")
	    time.sleep(tsleep)

		
def nikto():
        print("\033[1;31m [>]\033[1;m Updating Nikto, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/web/nikto/ && svn up") == 0):
	  
	  print("\033[1;31m [>]\033[1;m Nikto updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update Nikto.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Nikto' >> /root/bt5up.log")
		time.sleep(tsleep)
	


def beef():
        print("\033[1;31m [>]\033[1;m Updating BeEF, please wait.")
        time.sleep(tsleep)
        if(os.system("cd /pentest/web/beef/ && ./update-beef") == 0):
	  
	      print("\033[1;31m [>]\033[1;m BeEF updated successfully!")
	      time.sleep(tsleep)
	
	else:
		if(os.system("rm -Rf /pentest/web/beef;cd /pentest/web/;git clone git://github.com/beefproject/beef.git;cd /pentest/web/beef/; ./update-beef") == 0):
		      print("\033[1;31m [>]\033[1;m BeEF updated successfully!")
		      time.sleep(tsleep)		  
		else:		
		      print("\033[1;31m [>]\033[1;m Failed to update BeEF")
		      os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update BeEF' >> /root/bt5up.log")
		      time.sleep(tsleep)

def sqlmap():
        print("\033[1;31m [>]\033[1;m Updating Sqlmap, please wait.")
        time.sleep(tsleep)
        
        if(os.system("cd /pentest/database/sqlmap/ && ./sqlmap.py --update") == 0):
	  print("\033[1;31m [>]\033[1;m Sqlmap updated successfully!")
	  time.sleep(tsleep)
	
	else:
		print("\033[1;31m [>]\033[1;m Failed to update SQLmap.")
		os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update SQLmap' >> /root/bt5up.log")
		time.sleep(tsleep)
	

def sqlninja():
        print("\033[1;31m [>]\033[1;m Updating SQLNinja, please wait.")
        time.sleep(tsleep)
        if(os.system("svn co https://sqlninja.svn.sourceforge.net/svnroot/sqlninja /pentest/database/sqlninja") == 0):
	  
	      print("\033[1;31m [>]\033[1;m SQLNinja updated successfully!")
	      time.sleep(tsleep)
	
	else:
		if(os.system("apt-get purge sqlninja -y && svn co https://sqlninja.svn.sourceforge.net/svnroot/sqlninja /pentest/database/sqlninja") == 0):
		      print("\033[1;31m [>]\033[1;m SQLNinja updated successfully!")
		      time.sleep(tsleep)		  
		else:		
		      print("\033[1;31m [>]\033[1;m Failed to update SQLNinja")
		      os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update SQLNinja' >> /root/bt5up.log")
		      time.sleep(tsleep)
        

    
def nmap():
	print("\033[1;31m [>]\033[1;m Updating Nmap Fingerprints, please wait.")
	time.sleep(tsleep)
	if(os.system("wget http://nmap.org/svn/nmap-os-db -O /usr/local/share/nmap/nmap-os-db") == 0):
	    print("\033[1;31m [>]\033[1;m Nmap updated successfully!")	    
	    time.sleep(tsleep)	
	else:
	    print("\033[1;31m [>]\033[1;m Failed to update nmap!")
	    os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Nmap Fingerprints' >> /root/bt5up.log")
	    time.sleep(tsleep)
	   
	  


def fimap():
	print("\033[1;31m [>]\033[1;m Updating Fimap, please wait.")
        time.sleep(tsleep)
	
        os.system("rm -Rf /pentest/web/fimap")
	if(os.system("svn checkout http://fimap.googlecode.com/svn/trunk/src/ /pentest/web/fimap")==0):    
	    
            print("\033[1;31m [>]\033[1;m Fimap updated successfully!")
            
            time.sleep(tsleep)
        
        else:
            print("\033[1;31m [>]\033[1;m Failed to update Fimap!")
            os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Fimap' >> /root/bt5up.log")
            time.sleep(tsleep)
        
def wireshark():
    print("\033[1;31m [>]\033[1;m Updating Wireshark, please wait.")
    time.sleep(tsleep)
	
    os.system("apt-get install autoconf libgtk2.0-dev libglib2.0-dev libgeoip-dev libpcre3-dev libpcap0.8-dev libtool byacc flex -y")
    
    if (os.system("cd /tmp && svn co http://anonsvn.wireshark.org/wireshark/trunk/ wireshark")==0):
      print("\033[1;31m [>]\033[1;m Files downloaded successfully! Now the painful part... Be patient")
      time.sleep(tsleep)
      
      os.system("cd /tmp/wireshark && ./autogen.sh")
      os.system("cd /tmp/wireshark && ./configure")
      os.system("cd /tmp/wireshark && make")
      if (os.system("cd /tmp/wireshark && make install")==0):
	  os.system("ldconfig")
	  os.system("rm -Rf /tmp/wireshark")
	  if (os.path.isfile('/usr/local/share/wireshark/init.lua')):
	    print("\033[1;31m [>]\033[1;m Changeging init.lua file..")
	    time.sleep(tsleep)
	    
	    for lines in fileinput.FileInput("/usr/local/share/wireshark/init.lua", inplace=1): 
	      lines = lines.replace("disable_lua = false","disable_lua = true")
	  
	  print("\033[1;31m [>]\033[1;m Wireshark installed successfully!")
	  time.sleep(tsleep)
    else:
      print("\033[1;31m [>]\033[1;m Wireshark failed to install!")
      os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to update Wireshark' >> /root/bt5up.log")
      time.sleep(tsleep)

def update():
	print("\033[1;31m [>]\033[1;m Updating BT5UP script.")
	
	os.system("cd /tmp && wget http://bl4ck5w4n.tk/wp-content/uploads/2011/07/bt5up.tar -c -q")
	
	if os.path.isfile("/tmp/bt5up.tar"):
	    os.system("tar -xvf /tmp/bt5up.tar -C /tmp/ > /dev/null")
	    
	curfile = inspect.getfile(inspect.currentframe())
	
	pwd = os.getcwd() + str(curfile)
	
	os.system("rm -Rf " + pwd)
	os.system("mv /tmp/bt5up.py " + str(curfile))
	os.system("chmod +x " + str(curfile))
	
	
	print("\033[1;31m [>]\033[1;m Update successfully! bt5up will restart, please wait...")
	time.sleep(tsleep)
	python = sys.executable
	os.execl(python, python, * sys.argv)

  
  
def bugs_fixs():  
	header()
	print("			Section: Fix BT5 Bugs/Customize BT5")
	
        print("\033[1;31m [>]\033[1;m 1. Startx after login.")
        print("\033[1;31m [>]\033[1;m 2. Change Login message.")
        print("\033[1;31m [>]\033[1;m 3. Set PulseAudio to autostart.")
        print("\033[1;31m [>]\033[1;m 4. Set wicd autostart.")
        print("\033[1;31m [>]\033[1;m 5. FlashPlayer 11.")
        print("\033[1;31m [>]\033[1;m 6. Back.")
        bugs = raw_input("\033[1;31m [>]\033[1;m Enter your choice: ")
        
        if(bugs=="1"):
	    startx()
	    bugs_fixs()
	if(bugs=="2"):
	    login_msg()
	    bugs_fixs()
	if(bugs=="3"):
	    pulseaudio()
	    bugs_fixs()
	if(bugs=="4"):
	    wicd()
	    bugs_fixs()
	if(bugs=="5"):
	    flash()
	    bugs_fixs() 
	if(bugs=="6"):
	    main() 
 
 
 
def startx():
	print("\033[1;31m [>]\033[1;m Make startx as default...")
	os.system('echo \'if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ];\n then \nstartx \nfi\' >> /root/.bash_profile')
	print("\033[1;31m [>]\033[1;m Done. Next time you reboot startx will start...")
	time.sleep(tsleep)
	
def login_msg():
    print("\033[1;31m [>]\033[1;m Edit the login message using nano")
    time.sleep(tsleep)
    os.system("nano /etc/update-motd.d/10-help-text")
    os.system("sh /etc/update-motd.d/10-help-text")
    print("\033[1;31m [>]\033[1;m Next time you boot your message will be like that")
    time.sleep(tsleep)
    os.system("nano /etc/update-motd.d/10-help-text")
    os.system("sh /etc/update-motd.d/10-help-text")
    print("\033[1;31m [>]\033[1;m Next time you boot your message will be like that")
    time.sleep(tsleep)


def pulseaudio():
	print("\033[1;31m [>]\033[1;m Setting pulseaudio to autostart with Gnome")
	os.system("mkdir /root/.config/autostart")
	if (os.system('echo -e "\n[Desktop Entry]\nType=Application\nExec=/usr/bin/pulseaudio\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en_US]=PulseAudio Sound System\nName=PulseAudio Sound System\nComment[en_US]=Start the PulseAudio Sound System\nComment=Start the PulseAudio Sound System" >  /root/.config/autostart/pulseaudio.desktop')==0):
	    print("\033[1;31m [>]\033[1;m PulseAudio should autostart with Gnome now")
	    time.sleep(tsleep)
	else:
	    print("\033[1;31m [>]\033[1;m Failed to put PulseAudio in autostart")
	    os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to put PulseAudio in autostart' >> /root/bt5up.log")
	

def wicd():
      print("\033[1;31m [>]\033[1;m Setting wicd to autostart")
      if(os.system("dpkg-reconfigure wicd; update-rc.d wicd defaults")==0):
	print("\033[1;31m [>]\033[1;m wicd should autostart now")
	time.sleep(tsleep)
      else:
	print("\033[1;31m [>]\033[1;m Failed to put wicd in startup")
	os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to put wicd in startup' >> /root/bt5up.log")
      
def flash():
      print("\033[1;31m [>]\033[1;m Installing FlashPlayer 11")
      if(os.system("cd /tmp && wget http://fpdownload.macromedia.com/get/flashplayer/pdc/11.2.202.243/install_flash_player_11_linux_i386.tar.gz")==0):
	os.system("aptitude purge flashplugin-nonfree flashplugin-installer gnash gnash-common mozilla-plugin-gnash swfdec-mozilla -y")
	os.system("rm -f /usr/lib/firefox/plugins/libflashplayer.so")
	os.system("rm -f /usr/lib/mozilla/plugins/libflashplayer.so")
	os.system("rm -f /usr/lib/mozilla/plugins/flashplugin-alternative.so")
	os.system("rm -f /usr/lib/mozilla/plugins/npwrapper*flash*so")
	os.system("rm -f ~/.mozilla/plugins/*flash*so")
	os.system("mkdir ~/.mozilla/plugins")
	os.system("cd /tmp && tar -xvf install_flash_player_11_linux_i386.tar.gz")
	os.system("mv /tmp/libflashplayer.so ~/.mozilla/plugins/")
	print('\033[1;31m [>]\033[1;m Restart Firefox and the FlashPlayer should be working now...')
	time.sleep(tsleep)
      else:
	print("\033[1;31m [>]\033[1;m Failed to install FlashPlayer")
	os.system("echo '"+ strftime("%Y-%m-%d %H:%M:%S", gmtime()) +" - Failed to install FlashPlayer' >> /root/bt5up.log")
	
	
def latest_version():
	i=0
	lversion = 0
	if os.path.isfile("/tmp/version.txt"):
	    ofile=open("/tmp/version.txt","r")
	    lversion=ofile.readline()
	else:
	    os.system("cd /tmp && wget http://bl4ck5w4n.tk/wp-content/uploads/2011/07/version.txt -c -q")
	    ofile=open("/tmp/version.txt","r")
	    lversion=ofile.readline()
	
	return lversion

def clean_exit():
      print("\n\033[1;31m [>]\033[1;m Cleaning temporary files and leaving...")
      if os.path.isfile("/tmp/version.txt"):
	os.system("rm /tmp/version.txt")
      if os.path.isfile("/tmp/bt5up.tar"):
	os.system("rm /tmp/bt5up.tar")
      if os.path.isfile("/tmp/bt5up.py"):
	os.system("rm /tmp/bt5up.py")
      if os.path.isfile("/tmp/addtools_version.txt"):
	os.system("rm /tmp/addtools_version.txt")
	
      print("\n\033[1;31m [>]\033[1;m Thanks for using bt5up dont forget to visit: http://bl4ck5w4n.tk")
      print("\033[1;31m [>]\033[1;m If something went wrong check the log at /root/bt5up.log")
      print("\033[1;31m [>]\033[1;m For more options on how to use bt5up use: bt5up -h\n")
      
def header():
	os.system("clear")
	print('\033[1;31m                                        ,   ,')
	print('                                        $,  $,     ,')
	print('                                        "ss.$ss. .s')
	print('                                ,     .ss$$$$$$$$$$s,')
	print('                                $. s$$$$$$$$$$$$$$`$$Ss')
	print('                                "$$$$$$$$$$$$$$$$$$o$$$       ,')
	print('                               s$$$$$$$$$$$$$$$$$$$$$$$$s,  ,s')
	print('                              s$$$$$$$$$"$$$$$$""""$$$$$$"$$$$$,')
	print('                              s$$$$$$$$$$s""$$$$ssssss"$$$$$$$$"')
	print('                             s$$$$$$$$$$         `"""ss"$"$s""')
	print('                             s$$$$$$$$$$,              `"""""$  ')
	print('                             s$$$$$$$$$$$$s,... ')

        print("------------------------------------------------------------------------------\033[1;m")
	print("\033[1;37m	                 [Back||Track 5 R3 Update]\033[1;m")
        print(" Author: Bl4ck5w4n")
        print(" Feedback/Bugs : bl4ck5w4n5@gmail.com || http://bl4ck5w4n.tk || @Bl4ck5w4n")
        print("\033[1;31m------------------------------------------------------------------------------\033[1;m")
        if (float(get_version()) < float(latest_version())):
	  print("		Installed Version: \033[1;31m" + str(get_version()) + "\033[1;m Latest Version:\033[1;37m " + str(latest_version()) +"\033[1;31m------------------------------------------------------------------------------\033[1;m") 
	else:
	  print("		Installed Version: \033[1;32m" + str(get_version()) + "\033[1;m Latest Version:\033[1;37m " + str(latest_version()) +"\033[1;31m------------------------------------------------------------------------------\033[1;m")
	
	
def changelog():
	os.system("cd /tmp && wget http://bl4ck5w4n.tk/wp-content/uploads/2011/07/changelog.txt -o /dev/null")
	os.system("less /tmp/changelog.txt")
	os.remove("/tmp/changelog.txt") 

	
def gmail():

    print("\033[1;31m [>]\033[1;m Send me some feeback/bugs/requests (Please NO spam)...\n If you wanna go back just leave the email or pass in blank\n")
    gmailLogin = raw_input('\033[1;31m [>]\033[1;m Your GMail login (eg. someone@gmail.com): ')
    gmailPass = raw_input('\033[1;31m [>]\033[1;m Your GMail Password: ')
 
    if (gmailLogin!="" or gmailPass != ""):
      msg = raw_input('\033[1;31m [>]\033[1;m Your Message: ')
      msg = MIMEText(msg)
      msg['Subject'] = "BT5UP " +str(get_version()) +" FeedBack"
      msg['From'] = gmailLogin
      msg['To'] = "bl4ck5w4n5@gmail.com"
  
      server = smtplib.SMTP('smtp.gmail.com',587) 
      server.ehlo()
      server.starttls()
      server.ehlo()
      server.login(gmailLogin,gmailPass)
      server.sendmail(gmailLogin, "bl4ck5w4n5@gmail.com", msg.as_string())
      server.close()
      print("\033[1;31m [>]\033[1;m Thank you for your time...")
      time.sleep(tsleep)


def menu_exploit():

	header()
	
	print("			Section: EXPLOIT TOOLS")
	
        print("\033[1;31m [>]\033[1;m 1. Metasploit Framework.")
        print("\033[1;31m [>]\033[1;m 2. Exploit-db.")
        print("\033[1;31m [>]\033[1;m 3. SET - Social Engineering Toolkit.")
	print("\033[1;31m [>]\033[1;m 4. Update all.")
        print("\033[1;31m [>]\033[1;m 5. Back.")
        
        
	ex_var = raw_input("\033[1;31m [>]\033[1;m Enter your choice: ")


	if(ex_var=="1"):
		 msf()
		 
		 menu_exploit()
	if(ex_var=="2"):
		 exploit_db()
		 
		 menu_exploit()
	if(ex_var=="3"):
		 Set()
		 
		 menu_exploit()
	if(ex_var=="4"):
		  msf() 
		  exploit_db() 
		  Set()
		  
		  menu_exploit()
	if(ex_var=="1"): 
		  main()
	
	


def menu_wireless():

	header()

        print("                        Section: WIRELESS & TELEPHONY")
        
        print("\033[1;31m [>]\033[1;m 1. Aircrack-ng and Airdrop.")
        print("\033[1;31m [>]\033[1;m 2. WarVox.")
	print("\033[1;31m [>]\033[1;m 3. WiFite.")
	print("\033[1;31m [>]\033[1;m 4. Dedected.")
	print("\033[1;31m [>]\033[1;m 5. Fern Wifi Cracker.")
        print("\033[1;31m [>]\033[1;m 6. Giskismet.")
        print("\033[1;31m [>]\033[1;m 7. Update all.")
        print("\033[1;31m [>]\033[1;m 8. Back.")
        
        w_var = raw_input("\033[1;31m [>]\033[1;m Enter your choice: ")
	
	if(w_var=="1"):
		 aircrack()		 
		 menu_wireless()
	if(w_var=="2"):	 
		 warvox()		 
		 menu_wireless()
	if(w_var=="3"):	 
		 wifite()		 
		 menu_wireless()
	if(w_var=="4"):	 
		 dedected()		 
		 menu_wireless()
	if(w_var=="5"):	 
		 fernwifi()		 
		 menu_wireless()
	if(w_var=="6"): 
		giskismet()		
		menu_wireless()

	if(w_var=="7"): 
		aircrack()
		dedected() 
		fernwifi()
		wifite()	
		warvox() 
		giskismet()		
		menu_wireless()
	if(w_var=="8"): 
		main()
		 
	

def menu_web_db():
        header()
        print("                        Section: WEB & DATABASE")
        
        print("\033[1;31m [>]\033[1;m 1. W3AF.")
        print("\033[1;31m [>]\033[1;m 2. Nikto.")
	print("\033[1;31m [>]\033[1;m 3. BeEF.")
        print("\033[1;31m [>]\033[1;m 4. Sqlmap.")
	print("\033[1;31m [>]\033[1;m 5. SQLNinja.")
	print("\033[1;31m [>]\033[1;m 6. Fimap.")
        print("\033[1;31m [>]\033[1;m 7. JoomScan.")
        print("\033[1;31m [>]\033[1;m 8. WPScan.")
        print("\033[1;31m [>]\033[1;m 9. HexorBase.")
        print("\033[1;31m [>]\033[1;m 10. Update all.")
        print("\033[1;31m [>]\033[1;m 11. Back.")
        
        
        wd_war=raw_input("\033[1;31m [>]\033[1;m Enter your choice: ")
        
        if(wd_war=="1"):
	  w3af()	  
	  menu_web_db()
	if(wd_war=="2"):
		  nikto()		  
		  menu_web_db()
	if(wd_war=="3"): 
		  beef()		  
		  menu_web_db()
	if(wd_war=="4"): 
		  sqlmap()		  
		  menu_web_db()
	if(wd_war=="5"): 
		  sqlninja()		  
		  menu_web_db()
	if(wd_war=="6"): 
		  fimap()		  
		  menu_web_db()
	if(wd_war=="7"): 
		  joomscan()		  
		  menu_web_db()
	if(wd_war=="8"): 
		  wpscan()		  
		  menu_web_db()
	if(wd_war=="9"): 
		  hexorbase()		  
		  menu_web_db()
	if(wd_war=="10"): 
		  w3af() 
		  nikto()
		  beef()
		  sqlmap()
                  sqlninja()
		  fimap()
		  joomscan()
		  wpscan()
		  hexorbase()
		  menu_web_db()
	if(wd_war=="11"):  
		  main()
		  
		 

def menu_other():
	header()
        print("                        Section: OTHER")
	print("\033[1;31m [>]\033[1;m 1. Nessus.")
	print("\033[1;31m [>]\033[1;m 2. Wireshark.")
	print("\033[1;31m [>]\033[1;m 3. OpenVAS.")
	print("\033[1;31m [>]\033[1;m 4. Nmap.")
	print("\033[1;31m [>]\033[1;m 5. Update all.")
	print("\033[1;31m [>]\033[1;m 6. Back.")
	
	c_var = raw_input("\033[1;31m [>]\033[1;m Enter your choice: ")

	
	if(c_var=="1"):
		 nessus() 
		 menu_other()


	if(c_var=="2"):
		wireshark()
		menu_other()
	if(c_var=="3"):
		openvas()
		menu_other()
	
	if(c_var=="4"):
		nmap()
		menu_other()
	if(c_var=="5"):
		wr=raw_input("\033[1;31m [>]\033[1;m Wireshark takes time to compile do you wish to wait [y/N]:")
		if(wr=="y"):
		  wireshark()
		nessus() 
		nmap()
		openvas()
		menu_other()
	if(c_var=="6"):
		main()	
   
def additional_tools():
	header()
	tools.add_tools()
	    
	  
	
def main():
	header()
	print("                        Section: MAIN")
	print("\033[1;31m [>]\033[1;m 1. Update and clean Backtrack.")
	print("\033[1;31m [>]\033[1;m 2. Exploit tools.")
	print("\033[1;31m [>]\033[1;m 3. Wireless & Telephony.")
	print("\033[1;31m [>]\033[1;m 4. Web & Database.")
	print("\033[1;31m [>]\033[1;m 5. Others.")
	print("\033[1;31m [>]\033[1;m 6. Update all.")
	print("\033[1;31m [>]\033[1;m 7. Update script.")
	print("\033[1;31m [>]\033[1;m 8. Changelog.")
	print("\033[1;31m [>]\033[1;m 9. Feedback (GMail).")
	print("\033[1;31m [>]\033[1;m 10. Fix BT5 Bugs/Customize BT5.")
 	print("\033[1;31m [>]\033[1;m 11. Additional Tools")
        print("\033[1;31m [>]\033[1;m 12. Exit.")
 	
	
	choice_var=raw_input("\033[1;31m [>]\033[1;m Enter your choice: ")
	
	if(choice_var=="1"):
		 backtrack_update()
		 
		 main()
	if(choice_var=="2"):
		 menu_exploit() 
		 
		 main()
	if(choice_var=="3"):
		 menu_wireless() 
		 
		 main()
	if(choice_var=="4"):
		 menu_web_db()  
		 
		 main()
	if(choice_var=="5"): 
		 menu_other() 
		 
		 main()
	if(choice_var=="6"):
		wr=raw_input("\033[1;31m [>]\033[1;m Wireshark takes time to compile do you wish to wait [y/N]:")
		if(wr=="y"):
		  wireshark()
		backtrack_update() 
		exploit_db() 
		Set() 
		warvox() 
		aircrack()
		fernwifi()
		dedected()
		wifite() 
		giskismet() 
		msf() 
		nessus() 
		w3af() 
		nikto()
		joomscan()
		wpscan()
		nmap()
		sqlmap()
		sqlninja()
		beef() 	
		hexorbase()
		fimap() 
		openvas()
		main()
	if(choice_var=="7"):	
		 update()
	if(choice_var=="8"):
		 changelog()
		 
		 main()
	if(choice_var=="9"):
		 gmail()
		 main()
	if(choice_var=="10"):
		  bugs_fixs()
		  main()
	if(choice_var=="11"):
		  additional_tools()
		  main()
	if(choice_var=="12"):
		  clean_exit()
		  exit(0)
		  
		  
def automated():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hvu", ["help", "version","update"])
    except getopt.GetoptError, err:
        
        print str(err) 
        sys.exit(2)

    for o, a in opts:
	
        if o in("-v","--version"):
	    print(" \n BT5UP V.: " +  str(get_version()) + " - Tool to keep your BackTrack Updated and get new tools\n Author: Bl4ck5w4n")
	    print(" Feedback/Bugs: bl4ck5w4n5@gmail.com || http://bl4ck5w4n.tk || https://twitter.com/#!/Bl4ck5w4n\n")
        elif o in ("-h", "--help"):
	    print("\n\033[1;31m -----------------OPTIONS-----------------\033[1;m")
            print(" -v --version		VERSION")
            print(" -u --update 		Update All except WireShark")
            print(" -u wireshark 		Update All\n")
            print(" Example: bt5up -u wireshark\n")
            sys.exit()
        elif o in ("-u", "--update"):
	      if (len(sys.argv)==3):
		  if(sys.argv[2]=="wireshark"):
		    wireshark()
	      backtrack_update() 
	      exploit_db() 
	      Set() 
	      warvox() 
	      aircrack()
	      fernwifi()
	      dedected()		
	      wifite()	 
	      giskismet() 
	      msf() 
	      nessus() 
	      w3af()
	      wpscan()
	      joomscan()
	      nikto() 
	      nmap()
	      beef()
	      sqlmap()
	      sqlninja() 
	      hexorbase()
	      fimap() 
	      openvas()
	      os.system("clear")
	      print("\033[1;31m [>]\033[1;m Thanks for using bt5up, dont forget to visit: http://bl4ck5w4n.tk\n")


if __name__=="__main__":
  
  if (len(sys.argv) > 1):
    automated()
  else:
    main()
