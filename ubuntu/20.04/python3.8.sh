#!/bin/sh

pythonPath="/usr/local/python3.8/bin/python"
pipPath="/usr/local/python3.8/bin/pip"
packagePath="/home/Python-3.8.5.tgz"

if [ ! -x "$pythonPath" ]; then
    apt install -y gcc g++ wget curl llvm unzip xz-utils make build-essential vim openssl libssl-dev zlib1g zlib1g-dev bzip2 libbz2-dev sqlite libsqlite3-dev libncurses5-dev libreadline-dev tk-dev libgdbm-dev libdbi-dev libdb-dev libdb++-dev libpcap-dev xz-utils libffi-dev liblzma-dev
    cd /home/
    if [ ! -f "$packagePath" ]; then
        wget --no-check-certificate -O Python-3.8.5.tgz "https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz"
        #wget -O Python-3.8.5.tgz "http://10.110.26.159/Python-3.8.5.tgz"
    fi
    mkdir -p /home/Python-3.8.5
    tar xzf Python-3.8.5.tgz -C /home/
    chmod +x /home/Python-3.8.5/configure
    cd /home/Python-3.8.5/
    ./configure --prefix=/usr/local/python3.8 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" --enable-optimizations --with-lto
    make -C /home/Python-3.8.5
    make -C /home/Python-3.8.5 altinstall
    cp -f /usr/local/python3.8/lib/libpython3.8.so.1.0 /usr/local/lib
    cd /usr/local/lib
    ln -sf libpython3.8.so.1.0 libpython3.8.so
    rm -f /home/Python-3.8.5.tgz
    rm -rf /home/Python-3.8.5
    cd /usr/local/python3.8/bin/
    ln -sf python3.8 python
    ln -sf pip3.8 pip
    ln -sf pip3.8 pip3
fi
