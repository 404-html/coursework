sudo iptables -F
sudo iptables -A INPUT -p tcp --dport ssh -j ACCEPT
sudo iptables -A INPUT -p udp --dport ssh -j ACCEPT
sudo iptables -A INPUT -p tcp --dport ftp -j ACCEPT
sudo iptables -A INPUT -p udp --dport ftp -j ACCEPT
sudo iptables -A INPUT -p tcp --dport http -j ACCEPT
sudo iptables -A INPUT -p udp --dport http -j ACCEPT
sudo iptables -A INPUT -p tcp --dport https -j ACCEPT
sudo iptables -A INPUT -p udp --dport https -j ACCEPT
sudo iptables -A INPUT -p udp --dport 4445 -j ACCEPT
sudo iptables -A INPUT -s 192.168.1.102 -p tcp -j ACCEPT
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -p tcp --sport ssh -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport ssh -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport ftp -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport ftp -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport http -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport http -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport https -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport https -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 4444 -j ACCEPT
sudo iptables -A OUTPUT -d 192.168.1.102 -p tcp -j ACCEPT
sudo iptables -A OUTPUT -j DROP
