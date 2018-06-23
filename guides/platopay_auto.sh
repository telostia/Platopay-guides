#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install git -y
sudo apt-get install nano -y
sudo apt-get install curl -y
sudo apt-get install pwgen -y
sudo apt-get install wget -y
sudo apt-get install build-essential libtool automake autoconf -y
sudo apt-get install autotools-dev autoconf pkg-config libssl-dev -y
sudo apt-get install libgmp3-dev libevent-dev bsdmainutils libboost-all-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
cd
#get wallet files
wget https://raw.githubusercontent.com/telostia/vetani2-guides/master/wallet/linux/vetani_linux.tar.gz
tar -xvf vetani_linux.tar.gz
chmod +x vetani*
cp vetani* /usr/local/bin



#masternode input

echo -e "${GREEN}Now paste your Masternode key by using right mouse click and press ENTER ${NONE}";
read MNKEY

EXTIP=`wget -qO- eth0.me`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";
echo -e "${GREEN}Make a backup of wallet.dat incase if already existed to /root/wallet.bak ${NONE}";
sudo mkdir $HOME/.vetani

printf "addnode=54.149.181.41:38221\naddnode=5.9.180.147:38221\naddnode=74.208.94.204:38221\naddnode=104.207.158.193:38221\naddnode=138.68.165.112:38221\naddnode=54.149.181.41:38221\naddnode=95.179.140.249:38221\naddnode=104.237.149.64:38221\naddnode=185.233.105.172:38221\naddnode=45.76.146.140:38221\naddnode=185.53.191.78:38221\n\nrpcuser=vetani4323451345random\nrpcpassword=$PASSW\nrpcport=1977\nrpcallowip=127.0.0.1\ndaemon=1\nlisten=1\nserver=1\nmaxconnections=256\nexternalip=$EXTIP:38221\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.vetani/vetani.conf


vetanid -daemon
watch vetani-cli getinfo

