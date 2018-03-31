sudo iptables -F
sudo iptables -A INPUT -p tcp --dport 8081 -j DROP
sudo iptables -A INPUT -p tcp --dport ssh -j ACCEPT
sudo iptables -A INPUT -p udp --dport ssh -j ACCEPT
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -p tcp --sport ssh -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport ssh -j ACCEPT
sudo iptables -A OUTPUT -j DROP
