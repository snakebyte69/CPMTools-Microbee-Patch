#!/bin/sh
#===============================================================================
# Install script for Linux systems.
#
# The script will install the binary files.  It takes 1 or 2 parameters. If
# only 1 parameter is given then it is the destination location to install
# to.  If 2 parameters given then the second parameter determines if the
# binaries should be prefixed with the letter 'p'.  This may be used so that
# the tools can co-exist with an unpatched 'cpmtools'.
#
# The install.sh script needs to be in the same directory where the 'tools'
# directory is located.
#
# Usage examples:
#
# sudo ./install.sh /usr/local/bin/
# sudo ./install.sh /usr/local/bin/ prefix
#
# 'sudo' allows installing to a root location if 'sudo' is setup on the host
# system but may be left out to instll to a normal user location instead.
#===============================================================================

set -e

usage ()
{
 echo "Installs patched-cpmtools binary files with or without a prefix"
 echo ""
 echo "[sudo] ./install.sh destination_path"
 echo "[sudo] ./install.sh destination_path prefix"
 echo ""
 echo "Usage examples:"
 echo "sudo ./install.sh /usr/local/bin/"
 echo "sudo ./install.sh /usr/local/bin/ prefix"
 echo
 echo "Where 'prefix' is specified the prefix will be 'p' otherwise is not used."
 exit 1
}

destination=$1
prefix=$2

if [ "$destination" = "" ]; then
   usage
else
   if [ "$prefix" != ""  -a  "$prefix" != "prefix" ]; then
      usage
   fi
fi

# set the prefix character to be used or none
if [ "$prefix" = "prefix" ]; then
   prefix="p"
else
   prefix=""
fi

# create the destination directory if it does not exist
if [ ! -d $destination ]; then
   mkdir -p $destination
fi   

# install the list of files
list="cpmls cpmcp cpmrm cpmchmod cpmchattr mkfs.cpm fsck.cpm fsed.cpm diskdefs"

for file in $list
do
   if [ "$file" = "diskdefs" ]; then
      echo "Installing '$file' as '$file""$prefix'"
      cp ./tools/$file $destination/$file""$prefix
      chmod ug+x $destination/$file""$prefix

   else
      echo "Installing '$file' as '$prefix""$file'"
      cp ./tools/$file $destination/$prefix""$file
      chmod ug+x $destination/$prefix""$file
   fi
done
