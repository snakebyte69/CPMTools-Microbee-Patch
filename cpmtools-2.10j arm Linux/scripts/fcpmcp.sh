# Copy files from a floppy disk in a Floppyio unit to the local file system.
# This assumes it is connected as '/dev/ttyACM0'.

if [ "$1" != "" -a  "$2" != "" -a "$3" != "" ]; then
   topath=$4
   if [ "$topath" = "" ]; then
      topath="./"
   else
      mkdir -p $topath
   fi
   cpmcp -f $1 -T remote serial:/dev/ttyACM0,115200-crtscts,$2: $3 $4
else
   echo "Purpose: Copy files from a floppy disk in a Floppyio unit."
   echo "Usage  : $0 format drive files [to_path]"
   echo "Example: $0 ss80 a 0:*.*"
   exit 1
fi
