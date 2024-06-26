#!/bin/bash

if [ ! -f /root/eigenlayer/operator.yaml ]
then
 echo "eigenlayer operator setup not found, exiting..."
 exit 1
fi

cd ~
if [ -d avs-operator-setup ]; then rm -r avs-operator-setup; fi
git clone https://github.com/mangata-finance/avs-operator-setup.git
cd avs-operator-setup
chmod +x run.sh

read -p "ws rpc url? " ws
read -p "wallet password? " pwd

http=$(cat /root/eigenlayer/operator.yaml | grep eth_rpc_url | awk '{print $2}' )
name=$(cat /root/eigenlayer/operator.yaml | grep -w private_key_store_path: | awk -F "operator_keys/" '{print $NF}' | cut -d . -f 1 )
#bls=$(cat /root/eigenlayer/operator.yaml | grep -w bls_private_key_store_path: | awk -F "operator_keys/" '{print $NF}' )

sed -i "s#ETH_RPC_URL=#ETH_RPC_URL=$http#" .env
sed -i "s#ETH_WS_URL=#ETH_WS_URL=$ws#" .env
sed -i "s/ECDSA_KEY_PASSWORD=/ECDSA_KEY_PASSWORD=$pwd/" .env
sed -i "s/BLS_KEY_PASSWORD=/BLS_KEY_PASSWORD=$pwd/" .env

./run.sh opt-in
