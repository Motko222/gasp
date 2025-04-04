path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')

read -p "Sure? " c
case $c in y|Y) ;; *) exit ;; esac

cd ~/avs-operator-setup
docker-compose down

mv -f /root/avs-operator-setup /root/backup
mv -f /root/.eigenlayer /root/backup
[ -d /root/backup/scripts ] || mkdir /root/backup/scripts/$folder
mv -f /root/scripts/$folder/* /root/backup/scripts/$folder
rm -r /root/scripts/$folder
bash /root/scripts/system/influx-delete-id.sh $folder


