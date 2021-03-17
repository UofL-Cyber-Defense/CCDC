#!/bin/bash
# Description:
# Install Splunk Forwarder
# Usage:
# ./<SCRIPT NAME> 

printf "you need to run this script twice to get splunk setup.\nThere are also no firewall rules included, so you will have to make those\n"

if [[ "$(whoami)" != root ]]; then
  printf "Sudo or become root to run this script.\n"
  exit 1
fi

read -p "Ubuntu Web 1
Debian DNS/NTP 2
CentOS EComm 3 
Fedora Webmail 4
Ubuntu WorkStation 5
Manual Setup Mode 6
type the number for your box: " box


read -p "Have you downloaded splunk?
y or n: " installconfirm

if [[ $installconfirm != "n" ]]
then


if [[ $box != "6" ]]
then
read -p "Default forwad-server setup(do yes unless otherwise) y or n?: " setupmode
if [[ $setupmode != "n" ]]; then
read -p "enter ip address of the splunk server: " splunkip
/opt/splunkforwader/bin/splunk add monitor /var/log/SplunkedWtmp/
/opt/splunkforwader/bin/splunk enable boot-start
/opt/splunkforwader/bin/splunk add forwad-server $splunkip:27872	
	fi
fi


if [[ $box == "6" ]]
then
read -p "Add new forwad server? y or n: " monitormode
if [[ $monitormode == "y" ]]
then
read -p "Enter ip address of the splunk server: " splunkip
read -p "Enter port: " splunkport
/opt/splunkforwader/bin/splunk add forwad-server $splunkip:$splunkport
fi
fi

read -p "Use pre-setup monitoring(do yes, unless I say otherwise) y or n: " setupmonitoring
if [[ $setupmonitoring == "y" ]]
then
 
if [[ $box == "1" ]]
then
#Ubuntu Web
index="user"
if [[ $setupmode != "n" ]]; then
/opt/splunkforwader/bin/splunk add monitor /var/log/auth.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/daemon.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/dmesg -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/dpkg.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/faillog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/kern.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/messages -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/mysql.err -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/mysql -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/mysql.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/syslog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/iptables.log -index $index
fi

elif [[ $box == "2" ]]
then
#Debian DNS/NTP
index="internal"
if [[ $setupmode != "n" ]]; then
/opt/splunkforwader/bin/splunk add monitor /var/log/auth.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/syslog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/messages -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/faillog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/dpkg.log  -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/daemon.log  -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/iptables.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/cron.log  -index $index
fi

elif [[ $box == "3" ]]	
then
#fedora webmail, done
index="public"
if [[ $setupmode != "n" ]]; then
/opt/splunkforwader/bin/splunk add monitor /var/log/anaconda -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/cron -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/apache2 -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/maillog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/secure -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/yum.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/httpd -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/audit -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/messages -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/roundcubemail -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/iptables.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/fail2ban.log -index $index

fi


elif [[ $box == "4" ]]
then
#Centos Ecomm
index="public"
if [[ $setupmode != "n" ]]; then
/opt/splunkforwader/bin/splunk add monitor /var/log/yum.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/httpd -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/cron -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/dmesg -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/maillog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/messages -index $index
/opt/splunkforwader/bin/splunk add monitor /var/www/html/prestashop/log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/iptables.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/fail2ban.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/inotify.txt -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/mariadb -index $index

fi

elif [[ $box == "5" ]]
then
#Ubtuntu Wkst, proably done
index="user"
if [[ $setupmode != "n" ]]; then
/opt/splunkforwader/bin/splunk add monitor /var/log/auth.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/fail2ban.log -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/dpkg.log  -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/cron.log  -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/installer -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/syslog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/messages -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/faillog -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/dmesg.log  -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/daemon.log  -index $index
/opt/splunkforwader/bin/splunk add monitor /var/log/iptables.log -index $index
fi

elif [[ $box == "6" ]]
then
echo "You are in manual setup mode"
read -p "please enter the index name: " index


else
echo "please restart the script and chose a valid option"
exit 1

fi
fi
#needs to be run on all boxes

extralog=""
while [[ $extralog != "no" ]]
	do
	read -p "Please add any other files you would like to be monitored,
please include the full pathname(for example /var/log/auth.log)
type 'no' to exit : " extralog
	if [[ $extralog != "no" ]]
	then
	/opt/splunkforwader/bin/splunk add monitor $extralog -index $index
	fi
	done

/opt/splunkforwader/bin/splunk restart
/opt/splunkforwader/bin/splunk list forwad-server	


else

#this is a total fucking bodge job, and I love that it works.
read -p "Add wtmp monitering? (this creates a cronfile) y or n: " asktmp

if [[ $asktmp == "y" ]]
then
mkdir /var/log/SplunkedWtmp
cd /var/log/SplunkedWtmp
cat << EOF > /opt/cronWtmpSplunkUpdate.sh
#!/bin/bash
last -f /var/log/wtmp > /var/log/SplunkedWtmp/wtmptotext.sh
EOF

chmod +x /opt/cronWtmpSplunkUpdate.sh

#saving prior cronjobs then reinstating them, shouldn't mess anything up
crontab -l > mycron 
echo "*/10 * * * * /bin/bash /opt/cronWtmpSplunkUpdate.sh" >> mycron
crontab mycron
rm mycron
fi



cd /opt
read -p "Chose .tgz 8.1.1 unless there are problems. 
.deb 8.1.1 - 1 
(this one).tgz 8.1.1 - 2
.rpm 8.1.1 - 3
.tgz 8.0.0 - 4
.deb 8.0.0 - 5 

choose file format: " forwadVersion
if [[ $forwadVersion == "1" ]] 
then
wget -O splunkforwader-8.1.1-08187535c166-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.1&product=universalforwader&filename=splunkforwader-8.1.1-08187535c166-linux-2.6-amd64.deb&wget=true'
dpkg -i splunkforwader-8.1.1-08187535c166-linux-2.6-amd64.deb

elif [[ $forwadVersion == "2" ]] 
then
wget -O splunkforwader-8.1.1-08187535c166-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.1&product=universalforwader&filename=splunkforwader-8.1.1-08187535c166-Linux-x86_64.tgz&wget=true'
tar -xf splunkforwader-8.1.1-08187535c166-Linux-x86_64.tgz

elif [[ $forwadVersion == "3" ]] 
then
wget -O splunkforwader-8.1.1-08187535c166-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.1&product=universalforwader&filename=splunkforwader-8.1.1-08187535c166-linux-2.6-x86_64.rpm&wget=true'
rpm2cpio ./splunkforwader-8.1.1-08187535c166-linux-2.6-x86_64.rpm | cpio -idmv

elif [[ $forwadVersion == "4" ]]
then
wget -O splunk-8.0.0-1357bef0a7f6-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.0&product=splunk&filename=splunk-8.0.0-1357bef0a7f6-Linux-x86_64.tgz&wget=true'
tar -xf splunk-8.0.0-1357bef0a7f6-Linux-x86_64.tgz

elif [[ $forwadVersion == "5" ]]
then
wget -O splunkforwader-8.0.0-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.0&product=universalforwader&filename=splunkforwader-8.0.0-1357bef0a7f6-linux-2.6-amd64.deb&wget=true'
dpkg -i splunkforwader-8.0.0-amd64.deb
fi
/opt/splunkforwader/bin/splunk start --accept-license
fi