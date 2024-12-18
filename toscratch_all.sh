#!/bin/sh

# Удаление всех путей
echo "Default routes"
ip route
flush all

# Инициализация интерфейсов
echo "Default NICs"
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
echo "    vlan108:" >> /etc/netplan/60-config.yaml
echo "      id: 108" >> /etc/netplan/60-config.yaml
echo "      link: enp0s8" >> /etc/netplan/60-config.yaml
echo "      addresses: [134.12.56.72/21]" >> /etc/netplan/60-config.yaml
echo "    vlan115:" >> /etc/netplan/60-config.yaml
echo "      id: 115" >> /etc/netplan/60-config.yaml
echo "      link: enp0s9" >> /etc/netplan/60-config.yaml
echo "      addresses: [134.12.195.68/21]" >> /etc/netplan/60-config.yaml

# Очистка правил iptables
echo "Default iptables rules"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Перезагрузка системы
echo "Rebooting"
reboot
