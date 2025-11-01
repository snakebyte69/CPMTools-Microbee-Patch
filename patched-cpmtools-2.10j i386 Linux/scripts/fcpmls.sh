# List files on a floppy disk in a Floppyio unit.
# This assumes it is connected as '/dev/ttyACM0'.

if [ "$1" != "" -a  "$2" != "" ]; then
   cpmls -F -f $1 -T remote serial:/dev/ttyACM0,115200-crtscts,$2:
else
   echo "Purpose: List files on a floppy disk in a Floppyio unit."
   echo "Usage  : $0 format drive"
   echo "Example: $0 ss80 a"
   exit 1
fi
