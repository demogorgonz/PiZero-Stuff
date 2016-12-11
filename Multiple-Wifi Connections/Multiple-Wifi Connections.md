Edit /etc/wpa_supplicant/wpa_supplicant.conf and add id_str="EXAMPLE" under wpa info.
Your file should look similar to this:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="EXAMPLE NETWORK NAME 1"
    psk="EXAMPLE NETWORK NAME 1 PASSWORD"
    id_str="EXAMPLE1"
}

network={
    ssid="EXAMPLE NETWORK NAME 2"
    psk="EXAMPLE NETWORK NAME 2 PASSWORD"
    id_str="EXAMPLE2"
}
```


Then set up /etc/network/interfaces with iface EXAMPLE 1 inet static and iface EXAMPLE 2 inet static in it so it looks like the following:
```
auto lo

iface lo inet loopback
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf

iface example1 inet static
address <example1 address>
gateway <example1 gateway>
netmask <example1 netmask>

iface example2 inet static
address <example2 address>
gateway <example2 gateway>
netmask <example2 netmask>
```