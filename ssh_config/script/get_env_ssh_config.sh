#!/bin/bash

function help ()
{
	echo "\n  - Decription of this script:"
	echo -e "\t This script use to generate ssh config file entry for enviroments,\n\t it's args are:"
	echo -e "\t\t-- file which contain ips and hostnames, one recoed per line"
	echo -e "\t\t-- name of controller as u named it in .~/ssh/config"
	echo -e "\t\t-- private key of controller to access nodes"
	echo -e "\n\t\tEx: /bin/bash get_env_ssh_config.sh 'ru-hosts' 'ru-msk-dc1-ctrl' '~/.ssh/ru_ssh_id'"
	exit
}
if [[ $# != 3 ]]
then
	echo "[-] This script take three args "
	help
fi

ip_file=$1
ctrl_node=$2
key_file=$3
user="root"

base="$(echo ${ctrl_node::-5})"
echo "######################################"
for i in $(awk '{print $1}' ${ip_file})
do
	x=${i: -2}
	y=$(expr ${x} - 10)
	echo -e "Host ${ctrl_node}-$(grep ${i} ${ip_file} | awk '{print $NF}')\n\tHostName ${i}\n\tProxyJump ${ctrl_node}\n\tUser ${user}\n\tIdentityFile ${key_file}"
done
echo "######################################"
