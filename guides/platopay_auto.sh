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
wget https://raw.githubusercontent.com/telostia/vetani2-guides/master/wallet/linux/platopay.tar.gz
tar -xvf platopay.tar.gz
chmod +x platopay*
cp platopay* /usr/local/bin
ufw allow 16029/tcp


#masternode input

echo -e "${GREEN}Now paste your Masternode key by using right mouse click and press ENTER ${NONE}";
read MNKEY

EXTIP=`wget -qO- eth0.me`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";
sudo mkdir $HOME/.platopaycore

printf "addnode=185.206.145.110:16029\naddnode=185.203.116.31:16029\naddnode=45.77.150.255:16029\naddnode=62.77.159.54:16029\naddnode=34.201.131.134:16029\naddnode=185.177.59.222:16029\naddnode=85.214.116.88:16029\n\nrpcuser=platopayfsdyfosd\nrpcpassword=$PASSW\nrpcport=16028\nrpcallowip=127.0.0.1\ndaemon=1\nlisten=1\nserver=1\nmaxconnections=256\nexternalip=$EXTIP:16029\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.platopaycore/platopay.conf


platopayd -daemon
watch platopay-cli getinfo

