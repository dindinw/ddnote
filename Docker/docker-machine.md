NOTE About new docker-machine 
=============================

* `boot2docker` cli has migrated to `docker-machine` which officially released from Docker website  
* `boot2docker` ISO is still being used and it's the default VM installed with `Docker ToolBox`
* `Docker ToolBox` shipped also VBox and msgit, you can de-select them and install docker client and docker VM only (boot2docker ISO)
* `docker-machine` might got host-only-if can't created error when using VBOX, (restart OS and test to add a hostonly interface manually from VBOX UI might help)

By default, `docker-machine` will create a hostonlyif at `192.168.99.1`
```
$ VBoxManage list -l hostonlyifs
Name:            VirtualBox Host-Only Ethernet Adapter #2
GUID:            06e89d6d-4ba5-4845-ae82-6e5f2df9f760
DHCP:            Disabled
IPAddress:       192.168.99.1
NetworkMask:     255.255.255.0
IPV6Address:     fe80:0000:0000:0000:f593:cf8e:1abe:cace
IPV6NetworkMaskPrefixLength: 64
HardwareAddress: 08:00:27:00:a0:f8
MediumType:      Ethernet
Status:          Up
VBoxNetworkName: HostInterfaceNetworking-VirtualBox Host-Only Ethernet Adapter #2
```

* use `docker-machine env` where your old `boot2docker shellinit` used

References
----------
https://github.com/docker/machine
https://github.com/docker/toolbox
https://github.com/boot2docker
https://docs.docker.com/machine/migrate-to-machine/
https://www.virtualbox.org/manual/ch08.html#vboxmanage-hostonlyif

