path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')

cd ~/avs-operator-setup
docker-compose down

mv /root/avs-operator-setup /root/backup
mv /root/eigenlayer /root/backup
[ -d /root/backup/scripts ] || mkdir /root/backup/scripts
mv /root/scripts/$folder /root/backup/scripts
bash /root/scripts/system/influx-delete.sh $folder


