echo "Run this only once"

sudo apt-get install libusb-dev

wget https://raw.githubusercontent.com/codazoda/hub-ctrl.c/master/hub-ctrl.c

gcc -o hub-ctrl hub-ctrl.c -lusb

chmod +x hub-ctrl

sudo cp hub-ctrl /usr/bin
