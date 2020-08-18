#!/bin/sh

pythonPath="/usr/local/python3.8/bin/python"
pipPath="/usr/local/python3.8/bin/pip"
packagePath="/home/Python-3.8.5.tgz"

if [ ! -x "$pythonPath" ]; then
    yum install -y gcc wget unzip xz xz-libs make vim openssl openssl-devel zlib zlib-devel bzip2 bzip2-devel sqlite sqlite-devel ncurses-libs ncurses-devel readline-devel tk-devel gdbm-devel libdbi-devel db4-devel libpcap-devel xz-devel libffi-devel
    yum install -y centos-release-scl
    yum install -y devtoolset-9-gcc devtoolset-9-gcc-c++
    source /opt/rh/devtoolset-9/enable

    wget --no-check-certificate -O openssl.tar.gz https://www.openssl.org/source/openssl-1.1.1g.tar.gz
    tar xzf openssl.tar.gz -C /home
    cd /home/openssl-1.1.1g/
    ./config shared --prefix=/usr/local/openssl-1.1.1g --openssldir=/usr/local/openssl-1.1.1g
    make -C /home/openssl-1.1.1g
    make -C /home/openssl-1.1.1g install
    rm -rf /home/openssl-1.1.1g
    rm -f /home/openssl.tar.gz
    /bin/cp -f /usr/local/openssl-1.1.1g/lib/libssl.so.1.1 /usr/lib64/
    /bin/cp -f /usr/local/openssl-1.1.1g/lib/libcrypto.so.1.1 /usr/lib64/

    cd /home/
    if [ ! -f "$packagePath" ]; then
        wget --no-check-certificate -O Python-3.8.5.tgz "https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz"
    fi
    mkdir -p /home/Python-3.8.5
    tar xzf Python-3.8.5.tgz -C /home/
    chmod +x /home/Python-3.8.5/configure
    cd /home/Python-3.8.5/
    ./configure --prefix=/usr/local/python3.8 --with-openssl=/usr/local/openssl-1.1.1g --enable-shared --enable-optimizations --with-lto
    make -C /home/Python-3.8.5
    make -C /home/Python-3.8.5 altinstall
    /bin/cp -f /usr/local/python3.8/lib/libpython3.8.so.1.0 /usr/local/lib
    /bin/cp -f /usr/local/python3.8/lib/libpython3.8.so.1.0 /usr/lib64
    cd /usr/local/lib
    ln -sf libpython3.8.so.1.0 libpython3.8.so
    rm -f /home/Python-3.8.5.tgz
    rm -rf /home/Python-3.8.5
    cd /usr/local/python3.8/bin/
    ln -sf python3.8 python
    ln -sf pip3.8 pip
    ln -sf pip3.8 pip3
fi
