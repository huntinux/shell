#!/bin/bash

#
# update /etc/hosts to access google.com in China.
# echo "Usage: ./google_hosts hosts_url"
# example:  ./google_hosts.sh laod.cn/wp-content/uploads/2015/06/20150712-hosts.txt
# see laod.cn/hosts/2015-google-hosts.html
# huntinux 2015-7-14
#

# user must provide host url
hosts_url=${1:-emptyurl}
[ $# -eq 0 ] && { echo "Usage: $0 hosts_url"; exit 1;}
echo "hosts is here: $hosts_url"

# download hosts file
echo "Dowload hosts"
wget $hosts_url
newhosts=$(echo $hosts_url | awk -F'/' '{print $NF}')
echo "Dowload done."

# move to /etc
sudo mv /etc/hosts /etc/hosts.$(date | tr ' ' '_').bak
sudo mv $newhosts /etc/hosts

# add original hosts content
sudo echo "
# original start
127.0.0.1	localhost
127.0.1.1	huntinux-Lenovo-Product

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
# original end
" >>/etc/hosts

echo "DONE."
