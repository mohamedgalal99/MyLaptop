ip_file="ru-config"
ctrl_node="ru-msk-dc1-ctrl"
key_file="ru_ssh_id"
user="root"

base="$(echo ${ctrl_node::-5})"
echo "######################################"
for i in $(awk '{print $1}' ru-config)
do
	x=${i: -2}
	y=$(expr ${x} - 10)
	echo -e "Host ${base}-$(grep ${i} ${ip_file} | awk '{print $NF}')\n\tHostName ${i}\n\tProxyJump ${ctrl_node}\n\tUser ${user}\n\tIdentityFile ${key_file}"
done
echo "######################################"
