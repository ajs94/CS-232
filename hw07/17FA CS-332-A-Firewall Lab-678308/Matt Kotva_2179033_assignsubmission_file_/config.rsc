# dec/07/2017 02:42:39 by RouterOS 6.40.5
# software id = 
#
#
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip address
add address=192.168.114.1/24 interface=ether2 network=192.168.114.0
/ip dhcp-client
add disabled=no interface=ether1
/ip firewall filter
add action=accept chain=forward dst-address=45.60.31.34 dst-port=80 \
    in-interface=ether2 protocol=tcp
add action=accept chain=forward dst-address=45.60.31.34 dst-port=443 \
    in-interface=ether2 protocol=tcp
add action=accept chain=forward dst-address=104.196.190.195 dst-port=80 \
    in-interface=ether2 protocol=tcp
add action=accept chain=forward dst-address=104.196.190.195 dst-port=443 \
    in-interface=ether2 protocol=tcp
add action=accept chain=forward dst-address=66.35.59.249 dst-port=80 \
    in-interface=ether2 protocol=tcp
add action=accept chain=forward dst-address=66.35.59.249 dst-port=443 \
    in-interface=ether2 protocol=tcp
add action=accept chain=forward dst-address=153.106.4.99 dst-port=53 \
    in-interface=ether2 protocol=udp
add action=accept chain=forward dst-address=153.106.4.99 dst-port=53 \
    in-interface=ether2 protocol=tcp src-address-list=""
add action=accept chain=input dst-port=22 protocol=tcp src-address=\
    192.168.114.10
add action=accept chain=input dst-port=80 protocol=tcp src-address=\
    192.168.114.10
add action=reject chain=forward in-interface=ether2 reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=80 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=22 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=23 protocol=tcp reject-with=\
    icmp-network-unreachable
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=dst-nat chain=dstnat dst-port=3389 in-interface=ether1 protocol=\
    tcp to-addresses=192.168.114.10 to-ports=3389
/system ntp client
set enabled=yes
