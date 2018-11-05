if [[ -z $1 ]] 
	then
	echo "Usage $0 file"
fi
FILE=$1

while read line;
	do
	echo $line
	iptables -A INPUT -s "${line}" -j DROP
done<"$FILE"
service iptables save
iptables-save > /etc/iptables/rules.v4
