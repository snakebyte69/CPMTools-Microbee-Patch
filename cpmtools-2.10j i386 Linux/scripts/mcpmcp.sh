# Copy files from a floppy disk in a Microbee unit running FDS.COM.
# This assumes it is connected as '/dev/ttyUSB0'.

if [ "$1" != "" -a  "$2" != "" -a "$3" != "" ]; then
   topath=$4
   if [ "$topath" = "" ]; then
      topath="./"
   else
      mkdir -p $topath
   fi
   cpmcp -f $1 -T remote serial:/dev/ttyUSB0,19200-crtscts,$2: $3 $4
else
   echo "Purpose: Copy files from a floppy disk in a Microbee unit running FDS.COM."
   echo "Usage  : $0 format drive files [to_path]"
   echo "Example: $0 ss80 a 0:*.*"
   exit 1
fi
