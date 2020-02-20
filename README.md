# docker-dante
Dante socks proxy server


### Example sockd.conf
```
#logoutput: /var/log/sockd.log
#logoutput: stderr /var/log/sockd.log
logoutput: stderr

debug: 0
# debug: 0 - No debug logging
# debug: 1 - Some debug logging
# debug: 2 - Verbose debug logging

internal: 0.0.0.0 port = 1080
external: eth0
external.rotation:route

user.notprivileged: socks

clientmethod: none
socksmethod: none

# Allow IP's/Subnet to connect to this server
client pass {
	from: 192.168.1.0/24 to: 0.0.0.0/0
	log: error connect disconnect
}

# Allow outbound operations for connected clients on this server
socks pass {
	from: 0.0.0.0/0 to: 0.0.0.0/0
	command: bind connect udpassociate
	log: error # connect disconnect iooperation
}

# Allow inbound packets
socks pass {
	from: 0.0.0.0/0 to: 0.0.0.0/0
	command: bindreply udpreply
	log: error # connect disconnect iooperation
}
```
