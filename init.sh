#! /bin/bash

function init_net() {

    # net='/etc/sysconfig/network-scripts/'
    net='/etc/sysconfig/network-scripts/'
    ens=$(ls /sys/class/net | sed '/\(lo\| \)/d')

    sed -i 's/(BOOTPROTO=).*/\1static/' ${net}/${ens}
    sed -i 's/(ONBOOT=).*/\1yes/' ${net}/${ens}
    echo 'NETMASK=255.255.255.0' >> ${net}/${ens}
    echo 'NSD1=114.114.114.114' >> ${net}/${ens}
    read -p "IPADDR >" ipaddr
    read -p "GATEWAY >" gateway
    echo 'IPADDR='${ipaddr} >> ${net}/${ens}
    echo 'GATEWAY='${gateway} >> ${net}/${ens}
    service network restart
}

function init_ssh() {
    ssh-keygen -t rsa
    rm -rf ~/.ssh/**
    mv ./id_rsa ~/.ssh/id_rsa
    mv ./id_rsa.pub ~/.ssh/id_rsa.pub
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
    chmod 700 ~/.ssh/id_rsa
}