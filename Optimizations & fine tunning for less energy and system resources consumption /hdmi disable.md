## Disable Video/HDMI

After a new install there are a few things you're probably going to want to do.

First I would update the software running on your Zero:

    sudo apt-get update -y
    sudo apt-get upgrade -y

If you're going to be using your Zero completely headlessly like me there are various things you can do to save energy and speed up the device.

Boot up into multi-user mode (disable GUI on boot) `sudo systemctl set-default multi-user.target`.

To disable HDMI edit `/etc/rc.local` and add the following line at the bottom above `exit 0` line:

    /usr/bin/tvservice -o

You may want to run `sudo raspi-config` to change other common Raspberry Pi settings as well.