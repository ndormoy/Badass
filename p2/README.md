## Dans Routeur 1

1) ```ip link add br0 type bridge```
2) ```ip link set dev br0 up```
3) ```ip addr add 10.1.1.1/24 dev eth0```
4) ```ip addr show eth0``` --> pour voir si ca a marche
5) create VXLAN interface : 
```
ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
```
6) ```ip addr add 20.1.1.1/24 dev vxlan10```
7) ```ip -d link show vxlan10``` --> to show ou ```ifconfig vxlan10```
8) ```brctl addif br0 eth1```
9) ```brctl addif br0 vxlan10```
10) ```ip link set dev vxlan10 up``` --> upstate
11) Check si c'est up --> ```ip link show vxlan10```
12) Check si ca fait aussi bien parti de br0 :
```ip link show eth1```

## Dans Routeur 2 :

1)```ip link add br0 type bridge```
2)```ip link set dev br0 up```
3)```ip addr add 10.1.1.2/24 dev eth0```
4)
```
ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.1 local 10.1.1.2 dstport 4798
```
5)```ip addr add 20.1.1.2/24 dev vxlan10```
6)```ip link set dev vxlan10 up```
7)```ip link show vxlan10```
8)```brctl addif br0 eth1```
9)```brctl addif br0 vxlan10```

## Dans host_ndormoy-1 :

Donner une adresse ip a la machine alpine :

```ip addr add 30.1.1.1/24 dev eth1```

## Dans host_ndormoy-2 :

Donner une adresse ip a la machine alpine :

```ip addr add 30.1.1.2/24 dev eth1```

## Tester le ping :

1) cliquer droit sur sur la ligne entre routeur_ndormoy-1 et switch1 "start capture --> ok"