#!/bin/bash
set -e
if [ -e /tmp/proxy ]; then
    rm -rf /tmp/proxy
fi
mkdir /tmp/proxy
cd /tmp/proxy
wget https://github.com/reddec/monexec/releases/download/v0.1.1/monexec_0.1.1_linux_amd64.tar.gz
wget https://github.com/snail007/goproxy/releases/download/v2.1/proxy-linux-amd64.tar.gz

# install monexec
tar zxvf monexec_0.1.1_linux_amd64.tar.gz
cd  monexec_0.1.1_linux_amd64
cp monexec /usr/bin/
chmod +x /usr/bin/monexec
cd ..
# #install proxy
tar zxvf proxy-linux-amd64.tar.gz
cp proxy /usr/bin/
cp proxyd /usr/bin/
chmod +x /usr/bin/proxy
chmod +x /usr/bin/proxyd
if [ ! -e /etc/proxy ]; then
    mkdir /etc/proxy
    cp proxy.toml /etc/proxy/
fi

if [ ! -e /etc/proxy/proxy.crt ]; then
    cd /etc/proxy/
    proxy keygen >/dev/null 2>&1 
fi
rm -rf /tmp/proxy
echo "install done"
proxyd