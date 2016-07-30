[Source](https://davidmaitland.me/2015/12/raspberry-pi-zero-headless-setup/ "Raspberry Pi Zero Headless Setup")

# Raspberry Pi Zero Headless Setup

### [Raspberry Pi Zero Headless Setup][1]



## Step One - Install the Linux image

First you will need to install a copy of Raspbian Jessie onto your micro SD card. 

## Step Two - Mounting it locally

After you have copied the Raspbian image onto the SD card you will need to mount it to your system. The easiest way to do this is just unplug your card reader and plug it back in.

Once the drive has mounted to your system you will need to find where it has mounted. An easy way to do this is using the command `df -h`. For example for me it returns:

    Filesystem                       Size  Used Avail Use% Mounted on
    /dev/mapper/fedora_dhcppc8-root   25G  9.8G   14G  43% /
    /dev/sda1                        477M  258M  190M  58% /boot
    /dev/mapper/fedora_dhcppc8-home   85G   24G   58G  29% /home
    /dev/sdc1                         60M   20M   41M  34% /run/media/davidmaitland/boot
    /dev/sdc2                         59G  3.4G   53G   6% /run/media/davidmaitland/ad6203a1-ec50-4f44-a1c0-e6c3dd4c9202

I can see from this my 64GB SD card is the device **/dev/sdc** and the boot and main partition are mounted under `/run/media/davidmaitland/`. Change directory into the main partition as root ready to edit the files. This is likely to be the same drive that was referenced during the image installation earlier.

    [user@linux ~]# sudo su
    [root@linux ~]# cd /run/media/davidmaitland/ad6203a1-ec50-4f44-a1c0-e6c3dd4c9202
    [root@linux ad6203a1-ec50-4f44-a1c0-e6c3dd4c9202]# ls
    bin  boot  boot.bak  dev  etc  home  lib  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

## Step Three - Configure your WiFi

Next we're going to configure the network interface. Edit the interfaces file `etc/network/interfaces`. Pay attention to the path in the files I reference, there is no leading slash as you want to edit the files on your SD card and not the ones on your host system!

_If you're not sure how to edit files on Linux, try `nano etc/network/interfaces` then `Ctrl + x` to save when done._

Find this block in the file:

    allow-hotplug wlan0
    iface wlan0 inet manual
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

Then change it to this:

    auto wlan0
    allow-hotplug wlan0
    iface wlan0 inet dhcp
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

If you want to have a static IP instead of using DHCP (easier to find once the Pi has come up on your network) then change it to this instead:

    auto wlan0
    allow-hotplug wlan0
    iface wlan0 inet static
        address 192.168.1.20 # IP for the Zero
        netmask 255.255.255.0
        gateway 192.168.1.1 # Your router IP
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

As pointed out by someone on Reddit, if you're using static networking you will want to setup your DNS servers as well. Edit `etc/resolv.conf` and add the following:

    # Google's public DNS servers
    nameserver 8.8.8.8
    nameserver 8.8.4.4

Now let's setup the WiFi connection and passkey. Edit the file `etc/wpa_supplicant/wpa_supplicant.conf`.

Add this to the end:

    network={
      ssid="my network name"
      psk="my network password"
      proto=RSN
      key_mgmt=WPA-PSK
      pairwise=CCMP
      auth_alg=OPEN
    }

Finally remove the SD card from your computer (you may wish to unmount it first) and place into your Zero.

## Step Four - Boot the Pi Zero!

Now it's time to boot the Raspberry Pi Zero. Make sure you have your WiFi adapter plugged into the Zero and give it some power. For me it takes about **45** seconds to boot and connect to my WiFi network.

Now you can SSH directly into your Raspberry Pi Zero!

If you configured your Zero to use DHCP you will need to find it's IP address. There are a few ways you can do this:

* Most routers will tell you somewhere in their web interfaces what IP allocations they have assigned to devices.
* You could use [nmap][8] to scan the local network for devices running with port 22 open `sudo nmap -p22 -sV 192.168.0.0/24`.
* From the comments _Coder-256_ pointed out the default hostname for a Raspberry Pi is `raspberrypi` and on most networks you can SSH directly to this instead of the IP address `ssh pi@raspberrypi.local`.

The default password is `raspberry`.

    [user@linux ~]# ssh pi@192.168.1.20
    pi@raspberrypi:~ $