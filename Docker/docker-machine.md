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

### Environment
use `docker-machine env` where your old `boot2docker shellinit` used

### upgrade
you can alway upgrade your machine with `docker-machine upgrade` command
```
$ docker-machine.exe upgrade
Waiting for SSH to be available...
Detecting the provisioner...
Upgrading docker...
Stopping machine to do the upgrade...
Upgrading machine "default"...
Default Boot2Docker ISO is out-of-date, downloading the latest release...
Latest release for github.com/boot2docker/boot2docker is v1.10.2
Downloading C:\Users\Alex\.docker\machine\cache\boot2docker.iso from https://github.com/boot2docker/boot2docker/releases/download/v1.10.2/boot2docker.iso...
0%....10%....20%....30%....40%..
```
The above only update the host (server) to v1.10.2, then you need to curl a client
```
curl https://get.docker.com/builds/Windows/x86_64/docker-1.10.2.exe -o /c/Program\ Files/Docker\ Toolbox/docker.exe

$ docker --version
Docker version 1.10.2, build c3959b1

$ docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 1.10.2
Storage Driver: aufs
 Root Dir: /mnt/sda1/var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 0
 Dirperm1 Supported: true
Execution Driver: native-0.2
Logging Driver: json-file
Plugins:
 Volume: local
 Network: bridge null host
Kernel Version: 4.1.18-boot2docker
Operating System: Boot2Docker 1.10.2 (TCL 6.4.1); master : 611be10 - Mon Feb 22 22:47:06 UTC 2016
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 996.1 MiB
Name: default
ID: U4P3:GKND:MJHD:GVIQ:ROHK:F3UI:UCJL:3JHU:N6UH:ZAMP:5SYZ:OF66
Debug mode (server): true
 File Descriptors: 11
 Goroutines: 21
 System Time: 2016-03-02T07:03:00.931263742Z
 EventsListeners: 0
 Init SHA1:
 Init Path: /usr/local/bin/docker
 Docker Root Dir: /mnt/sda1/var/lib/docker
Labels:
 provider=virtualbox
```

References
----------
https://github.com/docker/machine
https://github.com/docker/toolbox
https://github.com/boot2docker
https://docs.docker.com/machine/migrate-to-machine/
https://www.virtualbox.org/manual/ch08.html#vboxmanage-hostonlyif


Note about compatible issue of v1 repository
============================================

need to install a lower version of docker for v1 repository.
try 1.8 version of boot2docker, but not work in windows for
> error : unable to prepare context: unable to evaluate symlinks in context path: readlink

finally, got 1.7.1 version of boot2docker working

env script to let two version docker co-exist,

```
export PATH=/c/Program\ Files/Boot2Docker\ for\ Windows/:$PATH
boot2docker up
eval `boot2docker shellinit`
docker --version
```

Tty issue in Windows platform for git-bash/mingw/Cgwin etc
==========================================================

use `winpty` to fix the issue

```
$ docker run --rm -ti centos7 /bin/bash
cannot enable tty mode on non tty input

$ winpty docker run --rm -ti centos7 /bin/bash
[root@822fd64b00a4 /]#

```
