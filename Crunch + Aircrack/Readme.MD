# This is example to pipe crunch to aircrack :

crunch 8 8 0123456789 | aircrack-ng -w - -b [AP MAC] file.cap
