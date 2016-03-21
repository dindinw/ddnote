Consul Note
===========

## Different between Dev mode and Default mode


```golang
/* 
 * github.com\hashicorp\consul\command\agent\config.go 
 *
 */

// DevConfig is used to return a set of configuration to use for dev mode.
func DevConfig() *Config {
	conf := DefaultConfig()
	conf.DevMode = true
	conf.LogLevel = "DEBUG"
	conf.Server = true
	conf.EnableDebug = true
	conf.DisableAnonymousSignature = true
	conf.EnableUi = true
	return conf
}
// DefaultConfig is used to return a sane default configuration
func DefaultConfig() *Config {
	return &Config{
		Bootstrap:       false,
		BootstrapExpect: 0,
		Server:          false,
		Datacenter:      consul.DefaultDC,
		Domain:          "consul.",
		LogLevel:        "INFO",
		ClientAddr:      "127.0.0.1",
		BindAddr:        "0.0.0.0",
// ........... lines omit 
	}
}
```

```
$ consul members
Node    Address          Status  Type    Build  Protocol  DC
master  10.245.2.2:8301  alive   client  0.6.4  2         dc1
```

```
[vagrant@openshift-minion-1 ~]$ consul agent -dev -bind=10.245.2.3 -join=10.245.2.2
==> Starting Consul agent...
==> Starting Consul agent RPC...
==> Consul agent running!
         Node name: 'openshift-minion-1'
        Datacenter: 'dc1'
            Server: true (bootstrap: false)
       Client Addr: 127.0.0.1 (HTTP: 8500, HTTPS: -1, DNS: 8600, RPC: 8400)
      Cluster Addr: 10.245.2.3 (LAN: 8301, WAN: 8302)
    Gossip encrypt: false, RPC-TLS: false, TLS-Incoming: false
             Atlas: <disabled>
```

```
[vagrant@openshift-master ~]$ consul members
Node                Address          Status  Type    Build  Protocol  DC
openshift-master    10.245.2.2:8301  alive   client  0.6.4  2         dc1
openshift-minion-1  10.245.2.3:8301  alive   server  0.6.4  2         dc1
```

### Test register

```
 echo '{"service": {"name": "sd", "tags": ["sd-server-1.2"], "port": 2013}}' > sd.json
```

```
consul agent -dev -bind=10.245.2.3 -join 10.245.2.2
```

```
curl -H "Content-Type: application/json" -X POST -d '{"name": "sd", "tags": ["sd-server-1.2"], "port": 2013}' http://localhost:8500/v1/agent/service/register
```


```
[vagrant@openshift-master ~]$ curl -s http://localhost:8500/v1/catalog/service/sd|python -m json.tool
[
    {
        "Address": "10.245.2.3",
        "CreateIndex": 6,
        "ModifyIndex": 6,
        "Node": "openshift-minion-1",
        "ServiceAddress": "",
        "ServiceEnableTagOverride": false,
        "ServiceID": "sd",
        "ServiceName": "sd",
        "ServicePort": 2013,
        "ServiceTags": [
            "sd-server-1.2"
        ]
    }
]
```

use `ServiceID` to deregister

```
curl http://localhost:8500/v1/agent/service/deregister/sd
```

