# dec/01/2017 21:49:34 by RouterOS 6.40.5
# software id = 
#
#
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip address
add address=192.168.110.1/24 interface=ether2 network=192.168.110.0
/ip dhcp-client
add disabled=no interface=ether1
/ip firewall filter
add action=accept chain=input dst-port=22 protocol=tcp src-address=\
    192.168.110.10 src-address-list="" src-port=""
add action=accept chain=input dst-port=80 protocol=tcp src-address=\
    192.168.110.10 src-address-list="" src-port=""
add action=accept chain=forward dst-address=153.106.4.99 dst-port=53 \
    protocol=tcp
add action=accept chain=forward dst-address=153.106.4.99 dst-port=53 \
    protocol=udp
add action=accept chain=forward dst-address=66.35.59.249 dst-port=443 \
    protocol=tcp
add action=accept chain=forward dst-address=66.35.59.249 dst-port=40 \
    protocol=tcp
add action=accept chain=forward dst-address=45.60.31.34 dst-port=443 \
    protocol=tcp
add action=accept chain=forward dst-address=45.60.33.34 dst-port=443 \
    protocol=tcp
add action=accept chain=forward dst-address=45.60.31.34 dst-port=40 protocol=\
    tcp
add action=accept chain=forward dst-address=45.60.33.34 dst-port=40 protocol=\
    tcp
add action=reject chain=input dst-port=80 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=23 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=input dst-port=22 protocol=tcp reject-with=\
    icmp-network-unreachable
add action=reject chain=forward in-interface=ether2 reject-with=\
    icmp-network-unreachable
/ip firewall nat
add action=dst-nat chain=dstnat dst-port=3389 in-interface=ether1 protocol=\
    tcp to-addresses=192.168.110.10 to-ports=3389
add action=masquerade chain=srcnat out-interface=ether1
/system ntp client
set enabled=yes
