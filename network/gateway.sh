interface="YOUR_INTERFACE"

sudo iptables -A FORWARD -i $interface -o $interface -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo iptables -A FORWARD -i $interface -o $interface -j ACCEPT

sudo iptables  --append FORWARD --in-interface $interface -j ACCEPT

sudo iptables --table nat --append POSTROUTING --out-interface $interface -j MASQUERADE
