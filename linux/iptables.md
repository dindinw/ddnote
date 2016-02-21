IPTABLES
========
linux kernel (since 2.4.x and later) can process network packet (at the layer 3), the subsystem named 
Netfilter. (http://www.netfilter.org/)
The `iptables` is the software to config the kernel (aka, the netfilter) at the user level. (sudo level)

必须注意INPUT和OUTPUT时候，对于源端口和目标端口的匹配，不同的匹配表达了不同的含有，务必注意这一点，例如下面这个实例，8080的服务器端口实际并没有被打开。，

WHY MY 8080 IS BLOCKED?
-----------------------

check 8080 is listening 
```
$ sudo netstat -tapnu | grep ":8080"
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN          
```

the wrong config
```
-A INPUT -i eth0 -p tcp -m state --state NEW,ESTABLISHED --sport 8080 -j ACCEPT
-A OUTPUT -o eth0 -p tcp -m state --state NEW,ESTABLISHED --dport 8080 -j ACCEPT

```

the correct one
```
-A INPUT -i eth0 -p tcp -m state --state NEW,ESTABLISHED --dport 8080 -j ACCEPT
-A OUTPUT -o eth0 -p tcp -m state --state ESTABLISHED --sport 8080 -j ACCEPT
```

BE CAREFUL
----------
注意TARGET and MATCH 都可以有Extension, 不要搞混淆。

>If  the  -p or --protocol was specified and if and only if an unknown option is encountered, iptables will try load a match module of the same name as the protocol, to try making the option available.

如果注意到这句话，就不用奇怪为啥写一个`-p tcp`就行了，不用再加一个`-m tcp`

REFERENCES
----------
* The official man page of `iptables`
```
$ man iptables  
$ man iptables-extensions 
```
* Rusty Russell's HOWTO
    * http://www.netfilter.org/documentation/HOWTO//packet-filtering-HOWTO.txt
* Linode's OpenVPN Setup Guide
    * https://www.linode.com/docs/networking/vpn/set-up-a-hardened-openvpn-server
    * https://www.linode.com/docs/networking/vpn/tunnel-your-internet-traffic-through-an-openvpn-server
* Linode's fail2ban Setup Guide
    * https://www.linode.com/docs/security/using-fail2ban-for-security




