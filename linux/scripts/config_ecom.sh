#!/bin/bash
# Description:
# This script configures the iptables then saves the iptables. Then it installs fail2ban and a splunk forwarder. Finally it modifys the php settings and stops list of services then checks the config.
# Usage:
# ./<SCRIPT NAME> 

iptables -X
iptables -F

iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -p tcp ! --syn -m state --state NEW -m limit --limit 1/min -j LOG --log-prefix "SYN packet flood: "
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

iptables -A INPUT -f -m limit --limit 1/min -j LOG --log-prefix "Fragmented packet: "
iptables -A INPUT -f -j DROP

iptables -A INPUT -p tcp --tcp-flags ALL ALL -m limit --limit 1/min -j LOG --log-prefix "XMAS packet: "
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

iptables -A INPUT -p tcp --tcp-flags ALL NONE -m limit --limit 1/min -j LOG --log-prefix "NULL packet: "
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

iptables -A INPUT -p icmp -m limit --limit 3/sec -j ACCEPT
iptables -A INPUT -p icmp -m limit --limit 1/minute -j LOG --log-prefix "ICMP Flood: "

iptables -A INPUT -m state --state established,related -j ACCEPT

iptables -A INPUT -p tcp --dport 25 -m state --state new -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -m state --state new -j ACCEPT
iptables -A INPUT -p tcp --dport 110 -m state --state new -j ACCEPT
iptables -A INPUT -p tcp --dport 143 -m state --state new -j ACCEPT

iptables -A FORWARD -f -m limit --limit 1/min -j LOG --log-prefix "Hacked Client, Master Callback: "
iptables -A FORWARD -p tcp --dport 31337:31340 --sport 31337:31340 -j DROP

iptables -A OUTPUT -o lo -j ACCEPT

iptables -A OUTPUT -f -m limit --limit 1/min -j LOG --log-prefix "Hacked Client, Master Callback: "
iptables -A OUTPUT -p tcp --dport 31337:31340 --sport 31337:31340 -j DROP

iptables -A OUTPUT -m state --state established,related -j ACCEPT

iptables -A OUTPUT -p tcp --dport 80 -m state --state new -j ACCEPT 

iptables -A OUTPUT -p tcp --dport 389 -d 172.20.242.200 -m state --state new -j ACCEPT
iptables -A OUTPUT -p tcp --dport 636 -d 172.20.242.200 -m state --state new -j ACCEPT
iptables -A OUTPUT -p udp --dport 389 -d 172.20.242.200 -m state --state new -j ACCEPT
iptables -A OUTPUT -p udp --dport 636 -d 172.20.242.200 -m state --state new -j ACCEPT

iptables -A OUTPUT -p tcp --dport 443 -m state --state new -j ACCEPT

iptables -A OUTPUT -p udp --dport 53 -m state --state new -j ACCEPT

iptables -A OUTPUT -p udp --dport 123 -d 172.20.240.1/22 -m state --state new -j ACCEPT

iptables -A OUTPUT -p udp --dport 27872 -d 172.20.241.20 -m state --state new -j ACCEPT

iptables -A OUTPUT -p icmp -m limit --limit 2/sec -j ACCEPT

iptables -A OUTPUT -m limit --limit 2/min -j LOG --log-prefix "Output-Dropped: " --log-level 4
iptables -A INPUT -m limit --limit 2/min -j LOG --log-prefix "Input-Dropped: " --log-level 4
iptables -A FORWARD -m limit --limit 2/min -j LOG --log-prefix "Forward-Dropped: " --log-level 4
iptables -A OUTPUT -p tcp --dport 27872 -d 172.20.241.20 -m state --state new -j ACCEPT
iptables -A INPUT -p tcp --dport 8089 -d 172.20.241.20 -m state --state new -j ACCEPT
iptables -A OUTPUT -p tcp --dport 8089 -d 172.20.241.20 -m state --state new -j ACCEPT

iptables-save > /etc/sysconfig/iptables
iptables-save > /opt/iptables

echo kern.warning	/var/log/iptables.log > /etc/rsyslog.conf

cd /var/log/
touch iptables.log

yum install fail2ban -y
systemctl stop firewalld
systemctl disabled firewalld
systemctl mask firewalld
mkdir /var/log/apache2
touch /var/log/apache2/error.log
touch /var/log/apache2/access.log
touch /var/log/mail.warn
touch /var/log/daemon.log
touch /var/log/roundcubemail/errors
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
systemctl enable fail2ban

wget -O splunkforward.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.1&product=universalforwarder&filename=splunkforwarder-8.1.1-08187535c166-Linux-x86_64.tgz&wget=true'
tar -xf splunkforward.tgz
sudo rm -rf /etc
sudo rm -rf /lib
mv splunkforwarder /opt
cd /opt/splunkforwarder/bin
./splunk start –accept-license
./splunk enable boot-start
./splunk add forward-server 172.20.241.20:27872
./splunk add monitor /var/log/httpd/access_log
./splunk add monitor /var/log/httpd/modsec_audit.log
./splunk add monitor /var/log/maillog
./splunk add monitor /var/log/roundcubemail/errors
./splunk add monitor /var/log/iptables.log
./splunk add monitor /var/log/fail2ban.log

echo "
expose_php=Off
display_errors=Off
log_error=On
error_log=/var/log/httpd/php_scripts_error.log
file_uploads=On
allow_url_fopen=Off
allow_url_include=Off
sql.safe_mode=On
magic_quote_gpc=Off
post_max_size=1K
max_execution_time = 30
max_input_time = 30
memory_limit = 40M
disable_functions= exec,passthru,shell_exec,system,proc_open,popen,curl_multi_exec,parse_ini_file,show_source
cgi.force_redirect = On " >> security.ini
cp security.ini /etc/php.d

systemctl stop atd 
systemctl stop crond stop
systemctl stop nfs-common stop
systemctl stop sshd stop
systemctl stop portmap 
systemctl stop avahi-daemon
systemctl stop anacron 

chkconfig atd off
chkconfig crond off
chkconfig nfs-common off
chkconfig sshd off
chkconfig portmap off
chkconfig avahi-daemon off
chkconfig anacron off




