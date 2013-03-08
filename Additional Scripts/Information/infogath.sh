#!/bin/sh 
echo -n "Please Enter Url: "
read url 
echo "Collecting Email Addresses,Domain Names,Client Names,Ip Addresses & PGP Key Info":
echo "Moving All Collected Information To /root/$url"
mkdir /root/$url
cd /pentest/enumeration/theharvester
./theHarvester.py -d $url -l 500 -b google > /root/$url/emailaddress
clear
echo "Collecting Email Addresses,Domain Names,Client Names,Ip Addresses & PGP Key Info":
echo "Moving All Collected Information To /root/$url"
./theHarvester.py -d $url -l 500 -b linkedin > /root/$url/names
clear
echo "Collecting Email Addresses,Domain Names,Client Names,Ip Addresses & PGP Key Info":
echo "Moving All Collected Information To /root/$url"
./theHarvester.py -d $url -l 500 -b pgp > /root/$url/pgpkeyserver
clear
echo "Collecting Email Addresses,Domain Names,Client Names,Ip Addresses & PGP Key Info":
echo "Moving All Collected Information To /root/$url"
cd /pentest/enumeration/google/goohost/
./goohost.sh -t $url -m host -p 10 -v
sleep 1
./goohost.sh -t $url -m mail -p 10 -v
sleep 1 
./goohost.sh -t $url -m ip -p 10 -v
clear
cat re* >> /root/$url/report
rm re*
cd /root/$url
cat * 
echo -n "Report Created Press Any Key To Continue:"
read any
