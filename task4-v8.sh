#!/bin/sh

# Удаление всех путей
echo "Default routes"
ip route flush all

# Очистка правил iptables
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Инициализация vlan
rm /etc/netplan/60-config.yaml
touch /etc/netplan/60-config.yaml
echo "network:" >> /etc/netplan/60-config.yaml
echo "  version: 2" >> /etc/netplan/60-config.yaml
echo "  renderer: networkd" >> /etc/netplan/60-config.yaml
echo "  ethernets:" >> /etc/netplan/60-config.yaml
echo "    enp0s8:" >> /etc/netplan/60-config.yaml
echo "      dhcp4: no" >> /etc/netplan/60-config.yaml
echo "    enp0s9:" >> /etc/netplan/60-config.yaml
echo "      dhcp4: no" >> /etc/netplan/60-config.yaml
echo "  vlans:" >> /etc/netplan/60-config.yaml
echo "    vlan2222:" >> /etc/netplan/60-config.yaml
echo "      id: 2222" >> /etc/netplan/60-config.yaml
echo "      link: enp0s8" >> /etc/netplan/60-config.yaml
echo "      addresses: [12.43.15.20/18]" >> /etc/netplan/60-config.yaml
echo "    vlan22:" >> /etc/netplan/60-config.yaml
echo "      id: 22" >> /etc/netplan/60-config.yaml
echo "      link: enp0s9" >> /etc/netplan/60-config.yaml
echo "      addresses: [112.43.60.200/11]" >> /etc/netplan/60-config.yaml

# Перезагрузка системы
echo "Rebooting"
reboot


# UB R
