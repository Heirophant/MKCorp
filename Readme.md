## NSS - 2 Final Project

### Description
This is a guide to how to setup the VMs on your machines so that everything runs smoothly. We have made and test all the machines on Oracle VirtualBox. _**I CAN'T BE SURE how VMs would behave in VMWare**_ since it has a different philosophy of attaching adapter to a machine. I haven't tested on VMWare but you are welcome to try.

### Objective

- Root the CTO box to get the flag.
- Flag has the format NullSec{*}

### Boot Sequence for VMs

Boot the VMs in the following order

- Firewall (takes about 60 to 90 secs)
- Server
- AD
- Manager
- CTO

The server is _**NOT**_ dependent upon AD so when you are trying to exploit the server you can keep other VMs off (except firewall) for better resource management.


### Setup

1. **Firewall** requires a Bridged Adapter (in Adapter 1) and a Internal Network (in this case already assigned ad_net) in Adapter 2. When you'll first import the ova file for this and try to boot it, it will prompt with an error __wlo1 not found__. For this you just have to assign the bridged adapter your physical laptop/desktop wifi NIC which you have installed. You can choose it from the drop down menu. After this everything should boot fine.

2. **Server**, **Manager Final** and **AD** should not pose any problems as they don't require any host interactions and are their own separate entites and are connected on internal network.

3. CTO box also require a Bridged Adapter therefore same procedure for Firewall would follow here.


### VPN
This would require some manual intervention on your part. The WAN IP for firewall is DHCP assigned. Thus making it dynamic. To handle this we would have to create a dynamic DNS entry which is not possible since there are ever so many DNS in which we would have to append the entry.

There is a workaround for it and the following steps describe it. A bash script couldn't be created for the reasons which would be clear.

A VM with Bridged adapter (say your attack machine) / or on host machine download a tool called __*arp-scan*__. Usually available with package managers (pre installed with kali).

Run
```
$ sudo arp-scan -l -I <bridged iface> -m /etc/arp-scan/mac-vendor.txt -O /usr/share/arp-scan/ieee-oui.txt
```

When done correctly this will show the IPs of the machine with their vendors. If running the Firewall in VirtualBox you will see the vendor as *PCS Systemtechnik GmbH*. This will be your Firewall IP. If you have multiple VMs running connected to the bridged adapter of your host machine you'll see the IPs for all of them. Thus it is recommended to only boot up the VM / Host plus the Firewall VM to extract the WAN IP of the Firewall.


After getting the WAN IP you would have to change the *__RedTeam VPN creds.ovpn__* for the IP in line 10. Instead of *192.168.0.108* replace the IP found above and connect to vpn using this command.


```
$ sudo openvpn --config ReadTeam\ VPN\ creds.ovpn
```


Credentials are as follows
```
username: redteam
password: tryhackme
```

After that you should be able to access the webserver on your web browser by using it's private IP.








