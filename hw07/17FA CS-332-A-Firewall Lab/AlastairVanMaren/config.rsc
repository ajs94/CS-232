# dec/01/2017 16:58:06 by RouterOS 6.40.5
# software id = 
#
#
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip address
add address=192.168.119.1/24 interface=ether2 network=192.168.119.0
/ip dhcp-client
add disabled=no interface=ether1
/ip firewall filter
add action=accept chain=input dst-port=80 protocol=tcp src-address=\
    192.168.119.10
add action=accept chain=input dst-port=22 protocol=tcp src-address=\
    192.168.119.10
add action=accept chain=forward dst-address=153.106.4.99 protocol=udp \
    src-port=53
add action=accept chain=forward dst-address=153.106.4.99 protocol=tcp \
    src-port=53
add action=accept chain=forward dst-address=45.60.31.34 dst-port=443 \
    protocol=udp
add action=accept chain=forward dst-address=45.60.31.34 dst-port=80 protocol=\
    udp
add action=accept chain=forward dst-address=66.35.59.249 dst-port=80 \
    protocol=udp
add action=accept chain=forward dst-address=66.35.59.249 dst-port=443 \
    protocol=udp
add action=reject chain=input dst-port=80 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=23 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=22 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=forward in-interface=ether2 reject-with=\
    icmp-network-unreachable
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=dst-nat chain=dstnat dst-port=3389 in-interface=ether1 protocol=\
    tcp to-addresses=192.168.119.10 to-ports=0-65535
/system ntp client
set enabled=yes
