Tuto : https://www.youtube.com/watch?v=D4nk5VSUelg

install busybox with the alpine image

## I/ Install gns3 :

1) ```sudo rm /var/libdpkg/gns3```
2) ```sudo add-apt-repository ppa:gns3/ppa```
3) ```sudo apt update```
4) ```sudo apt install gnome-session-flashback```
5) ```sudo apt install gns3-gui```

## II/ Install Docker :

```sudo apt install docker.io```

## III/ Reboot the machine :

## IV/ Check if all is installed :

1) Check if gns3 is installed in system tools
2) Check if docker is installed :
```docker ps``` --> we don t have rights
```sudo usermod -a -G docker myusername```
3) Reboot the machine again
4) ```docker ps```

## V/ Get the FRR Image :

1) ```docker pull frrouting/frr``` --> Do this in dockerfile
2) Check if frr image is available --> ```docker images``
3) ```docker pull alpine```

## V/ Run images :
1) ```docker run -d frrouting/frr```
2) ```docker ps``` --> Check if frr image is mounted

## VI/ Enter in the container :
```docker exec -it recursing_shirley sh```

(recursing_shirley is the name when we do docker ps)

##  VI/ Remove container :
1) ```docker stop recursing_shirley```
2) ```docker rm recursing_shirley```

## VII/ Install Wireshark without errors :
1) Change the groupe to our user :
```sudo chgrp myusername /usr/bin/dumpcap```
2) Give permissions :
```sudo chmod 754 /usr/bin/dumpcap```
3) Give capabilities to the program :
```sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap```

## VIII/ Adding Docker image into GNS3 :

before :  ```sudo apt install gnome-terminal```

1) Launch GNS3 Program
2) Create the project (the box is already here on the opening of the program, the press ok with the name that we want)
3) edit --> preferences --> docker --> docker containers
4) Click on new
5) Image list: frrouting/frr:latest
6) Name it : "gns3"
7) adapters : 1
8) Start command : leave it empty
9) Console type : telnet
10) Environment : leave it empty
11) click on finish
12) Click on apply
13) Click on OK
14) Click on Browse all devices (at the left) and find : "gns3"
15) drag and drop gns3 on the middle
16) Run with the play button


----------------

## Les images docker (ON est deja dans une VM) 

Il nous en faut 2 :

1) L'image alpline (ON doit installer busybox a cause du sujet)
```
FROM alpine:latest

RUN apk upgrade && apk update && apk add busybox
```

2) L'image frr
```
FROM frrouting/frr
ENV DAEMONS="zebra bgpd ospfd isisd"
COPY ./daemons.conf /etc/frr/daemons.conf
RUN chown frr:frr /etc/frr/daemons.conf
```

on peut remplacer ca : ENV DAEMONS="zebra bgpd ospfd isisd"
si on a deja fait la mise en place de zebra bgpd ospfd isisd dans le daemon.conf, donc plus besoin

------------------

## Pour Check si tout va bien sur l'interface :

1) ```vtysh```
2) ```sh int```

-----------------

## Configurer routeur 1:

Click droit --> Auxiliary console sur routeur_ndormoy-1

1) ```vtysh```
2) ```conf t```
3) On arrive ici : (config)#
```int lo```
4) On arrive ici (config-if)#
```ip addr 1.1.1.1/32``` --> On donne une adresse ip a l'adresse de loopback
5) ```int eth0```
6) ```ip addr 10.1.1.1/30```
7) ```routeur ospf```
8) ```network 0.0.0.0/0 are 0``` --> enable on all the interfaces

9) Pour tester si tout est up :
```do sh ip ospf ip int```
ON regarde si c'est active sur loopback 0 et eth0

10) Pour check un peu plus :
```do sh ip ospf neighbor```
```do sh ip route```
```do ping 1.1.1.1``` --> ON doit pouvoir le pinger

11) A voir si on a besoin qu'avec qu'un routeur
```router isis 1```
```net 49.0000.0000.0001.00```
```int lo```
```ip router isis 1```
```int eth0```
```ip router isis 1```
```do sh isis int``` --> Pour check
