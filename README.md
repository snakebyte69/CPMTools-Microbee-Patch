# CPMTools Microbee Patch #
## Windows, macOS, Linux build instructions go here ##
### macOS ###
Install libdsk
% brew install libdsk

#### Apply the patch ####
- % cd cpmtools-2.10
- % patch < cpmtools-2.10j-ubee.patch

Build with libdsk
- % ./configure --with-libdsk=/opt/homebrew
- % make
- % sudo make install
- 
 - copy microbee diskdefs to
 /usr/local/share/

Building patched cpmtools
=========================
The patched-cpmtools is dependent on LibDsk being available and is needed
for all RAW and other disk image formats including floppy disks.

To build the 'fsed.cpm' utility in requires that an 'ncurses' development
package is installed on the system.  The 'cpmtools' configure script will
determine whether it exists.

The 'xxr' here represents the 'cpmtools' version (xx) and patch (r) revision
letter.

To build cpmtools-2.xx follow these directions (Ubuntu Hardy):

Make a new directory in your home account to work in:
- $ mkdir cpmtools
- $ cd cpmtools

Copy the cpmtools-2.xxr-ubee.patch file to this directory.

Untar the cpmtools-2.xx original tar distribution:
- $ tar -xzf cpmtools-2.xx.tar.gz

Apply the patch file:
- $ patch -p0 < cpmtools-2.xxr-ubee.patch

Copy the build.h file from the patch distribution
- $ cp build.h cpmtools-2.xx

Build CP/M tools:
- $ cd cpmtools-2.xx
- $ ./configure OPTIONS
- $ make

Install as user root with sudo or log in as root:
- $ sudo make install

# Original ReadMe #
cpmtools-2.10j-ubee.patch - uBee 2016/11/16
===========================================

Overview
========
This patch is provided under the GPL. Please see the GPL COPYING licence.

This patched version of 'cpmtools' allows access to all Microbee disks using
the LibDsk interface.  The standard version of cpmtools is not able to do
this because of Microbee's strange sector numbering and skewing method
employed.  The patched version is able to access disks in a "physical"
format rather than a "logical" format so making it more flexible.

The current version of 'cpmtools' is available from the author's web site:

http://www.moria.de/~michael/cpmtools/

This patch is only designed to be patched up against the version shown at
the top of this file.  If this version is not available from the above site
then it can be downloaded from:

http://www.microbee-mspp.org.au/repository

Look under 'Utilities/patched_cpmtools'.

I will only be patching newer versions of 'cpmtools' if it's really needed.
The current version may see some patch revisions: a, b, c, etc.

Most of the 'cpmtools' sources have been patched to some degree.  'cpmfs.c'
and 'device_libdsk.c' are two files that have seen the most changes.

'device_win32.c' and 'device_posix.c' have also been patched to a much
lesser degree, but these two won't be compiled in when LibDisk is set to be
compiled in.

The following 'cpmtools' utility sources have been patched.  The main
changes common to all of these is to allow some extra LibDsk command line
options to be specified:

cpmchattr.c
cpmchmod.c
cpmcp.c
cpmls.c
cpmrm.c
fsck.cpm.c
fsed.cpm.c

The following support sources have also been patched:

device_posix.c
device_libdsk.c
device_win32.c

Direct floppy disk access using the built in LibDsk will work under W2000 or
later OS and Linux.  On Windows systems the 'ntwdm' floppy filter driver
must be installed and called up with '-T ntwdm'.  The driver can be
downloaded from here:

http://simonowen.com/fdrawcmd/

On Linux systems '-T floppy' must be specified and the user must have access
rights to the floppy disks.

Any of the other 'cpmtools' programs that try to access the system tracks
will most likely not work as intended.  Those programs will require some
extra functionally programmed in.  The main issue is that Microbee sectors
for the system and data tracks may be arranged differently.

IMPORTANT INFORMATION
=====================
Differences in systems, drivers, floppy drives, FD Controllers exist.  How
well the copying process works can depend on these and many other factors.

It is important to realise that an unsuccessful read on one set-up may work
on another and even if the disk can't be read without error does not mean
the disk is bad.  There are other alternative methods to recover data from
disks if this patched program can not.

For Floppy disks it is recommended to make a disk image of the floppy disk
first then use these tools to access the disk image only.  Using a floppy
disk imaging program such as 'ubeedisk' allows for retries and pausing to
allow the user to clean the disk heads during the imaging process.

The 'ubeedisk' program, sources and documentation containing some examples
can be found here:

http://www.microbee-mspp.org.au/repository

Look under 'Utilities/ubeedisk'.

Distribution Packages
=====================
Distribution packages exists for Linux, Win32 and Raspberry Pi.  The root of
these packages contains the GNU License, patch file and other documents.

The 'tools' directory contains the binary executables and 'diskdefs' disk
definitions file.

The 'man' directory contains the manual pages in 'man' format.

http://www.microbee-mspp.org.au/repository

Look under 'Utilities/patched_cpmtools'.

The binary files may be easily installed by running 'install.sh' under Linux
or 'install.bat' under Windows.  Follow the usage information.  The script
is able to prefix the binaries with the letter 'p' so that they do not
conflict with non patched 'cpmtools'.  If using the 'prefix' option the
'diskdefs' file will have 'p' appended to it.

The 'man' pages will not be installed and have not been edited for the
patched 'cpmtools' build.

fsed.cpm
--------
From rev 2.10i 'fsed.cpm' program should now work as intended and is also
now included in the Windows distribution package.  It does not appear to be
able edit though and is more a disk viewing program.  It is able to view the
system and data tracks and provides some useful information found in the
directory entries.

There is a map function that can be accessed by pressing the 'm' key but
this may not work and may exit with an error depending on the disk format. 
It is not clear what the map function actually is.  It appears to be
something not fully completed and possibly was only intended for debugging
purposes hence there is no menu entry for it.

The diskdefs file
=================
From rev 2.10i the 'diskdefs' may be renamed to 'diskdefsp'.  Where this
documentation refers to 'diskdefs' it also means 'diskdefsp'.

The trailing 'p' denotes for use with these patched-cpmtools.  This will
allow a non-patched and patched distribution 'diskdefs' to be used in the
same environment without conflicting.  The 'diskdefsp' name takes precedence
over 'diskdefs' in this package.

On Windows systems the 'diskdefs(p)' file should be located in the same
directory as the 'cpmtools' programs or the current directory.

On Unix systems the 'diskdefs(p)' file may be located in up to three
different locations.  First a '.diskdefs(p)' file (note the dot) is checked
for in the user's home account.  If not present then the current directory
is checked for a 'diskdefs(p)' file and if not found a final check for a
system 'diskdefsp' file is checked for in the /usr/local/share/ directory. 
The actual path is determined by the Makefile when building.

It is up to the user to copy the supplied 'diskdefs' file to the required
location and edit it as required.

This patch gives 'cpmtools' the ability to access disks using physical
parameters in the 'diskdefs' file.  The 'patched-cpmtools' optional
parameters are as follows:

cylinders n
datarate n
datasect n
fm n
heads n
sidedness n
sideoffs n
skewstart n
testside n

cylinders n
-----------
The 'cylinders' value specifies the number of cylinders on the media.
Cylinders here means the number of physical cylinders.  This parameter if
specified overrides the 'tracks' parameter if one was specified.  The
'tracks' value is the logical number of tracks.

datarate n
----------
The 'datarate' may be used instead of specifying the "-L x" option on the
command line.  If "-L x" if specified overrides the 'diskdefs' setting if
one was used.  If no setting specified then the default LibDsk data rate is
used.

The value of 'n' represents the following rates:

0 : High Density (hd)
1 : Double Density (dd)
2 : Single Desnity (sd)
3 : Extended Density (ed)

See the "-L x" option below for more information.

datasect n
----------
The 'datasect' value allows the first physical sector on the data tracks to
be specified.  Normally this is 1 on most disks. The value defaults to 1 for
existing formats in 'diskdefs'.

fm n
----
The 'fm' value determines if the disk uses FM encoding (commonly referred to
as single density) by setting n=1. The default value of 'fm' is 0 for MFM
encoded disks (double density).

heads n
-------
The 'heads' parameter is used in conjunction with the 'cylinders' value.
Typically both of these are normally specified.  The 'heads' value is also
used by the CP/M file location report feature in this patch release
discussed further on.

sidedness n
-----------
The 'sidedness' value determines how a disk with 2 sides is accessed. By
default the value is set to Alternate (0) which is what most disks are.

0 : Alternate. H0C0 H1C0 H0C1 H1C1 H0C2 H1C2 ... H0C39 H1C39

1 : Outback. H0C0, H0C1, H0C2 ... H0C39 -- H1C39 H1C38 H1C37 ... H1C0

2 : Outout. H0C0, H0C1, H0C2 ... H0C39 -- H1C0 H1C1 H1C2 ... H1C39

3 : Special Nanowasp disk image only (not a LibDsk Nanopwasp format) 

The sidedness will be carried out within cpmtools and not passed onto LibDsk
to be handled.  The cpmtools MAP output option will also use the sidedness
value.  It is expected that the disk images have the same physical
arrangement as the floppy disk so that the order is always H0C0 H1C0 H0C1
H1C1 etc.

sideoffs n
----------
The 'sideoffs' value allows disks that use a different value in the sector
header for the side value when it is not equal to the head value.  When
specifying this value (1-255) the 'testside' value will also be set
internally if the value is non-zero.

An example is a disk format that uses 128 (side 0) and 129 (side 1) in the
side value.  The high bit (bit 7) is used to indicate the disk is double
sided.

If the disk type (i.e. DSK, ntwdm, floppy, remote, etc) supports sector ID
reading then 'testside 1' may be all that is required but better to cover
formats that don't support this function and use the 'sideoffs' value
instead.

skewstart n
-----------
The 'skewstart' was introduced for Microbee disks so that the skew table
could be calculated correctly.  This value defines the first physical sector
used for logical sector 0.  Normally this is 1 on most disks. The value
defaults to the correct value for existing formats in 'diskdefs'.

Microbee system tracks are not skewed and start from sector 1.  The patches
only allow the 'cpmtools' that are concerned with the directory/data tracks
to work correctly.

testside n
----------
The 'testside' value determines if a test is made for the sector ID during
read and write operations.  Some disks (especially Microbee) uses a sector
ID of 0 on physical side 1 of disks.  To use this option specify n=1.

This parameter will be used when the disk type is not a 'raw' type.

Command line options
====================
If the '-T libdsk_type' option is missing from the command line then the
default type will be a 'raw' image type file.  To access floppy disks and
other image types the appropriate value must be specified.  See the LibDsk
documentation for other 'libdsk_type' values.

Some new command line options have been added to this patched version.

 -L x  LibDsk options (x) separated by spaces and double quotes.
             hd : data rate for 1.4Mb 3.5" in 3.5" drive.
             dd : data rate for 360k 5.25" in 1.2Mb drive.
             sd : data rate for 720k 3.5" in 3.5" drive.
             ed : data rate for 2.8Mb 3.5" in 3.5" drive.
          dstep : double step (40T disk in 80T drive)

These options allows the LibDsk floppy handler built into 'cpmtools' to
access floppy disks at a different data and/or stepping rate if needed.

Alternatively a 'datarate' rate may be specified in a 'diskdefs' definition. 
If an "-L x" data rate option is used it overrides the 'diskdefs' value.

 -v    Report build version.

The 'fsck.cpm' program has an '-i' option that may be used to report
information about a particular format, this information may be used by
scripts.

The information output is a follows:

Cylinders Heads Sectors_per_track Sector_size Boot_tracks Sidedness

Example:

fsck.cpm -f ds40 -T dsk -i disk-ds40.dsk
40 2 10 512 2 0

cpmls and cpmcp -e option
-------------------------
From version 2.10j onwards the 'cpmls' and 'cpmcp' command includes an '-e'
option allowing erased files only to be worked on.  This allows for easy
recovery of files that had been marked as erased on the disk without
actually modifying the disk itself.  The recovered file(s) may or may not be
intact depending on what and where data was written to the disk after the
file had been erased.

To reliably recover erased files do it immediately after it has been erased
and before writing any more data to the disk.

When using the '-e' option actual files that have not been erased are
ignored.  The '-e' option will only list and copy files that have been
erased.

If a disk had files that had been erased and no further other write actions
to the directory or the data structure occurred the files can most likely be
recovered without loss or corruption.

If the disk was written to after erasing a file it depends on the CP/M
operating system whether the file data or even directory entries have been
reused.  Later CP/M systems may have reused directory and data areas only if
no other space was available.  This is highly dependent on how the system
works though.

An erased file is considered valid where the directory contains 0xe5 in the
1st byte location (User byte) and then only if the 2nd byte is not 0xe5. 
The check of the 2nd byte helps determine if a real directory entry had
existed and not simply formatted data.

When using 'cpmls' it will list the same erased file name more than once if
there is more than one main entry in the directory by that name.  The -F
option may be used to see file sizes.

When using 'cpmcp' to copy files to the host system each recovered file will
have '_ERASED-000n' appended to it.  The value of 'n' is incremented each
time.  This not only makes it clear that the file has been recovered but is
also necessary where there is more than one main erased entry by the same
name so prevents each recovered file overwriting each other.

Example:
Where there may be 2 different erased files using the name 'myfile.txt':

myfile.txt_ERASED-0001
myfile.txt_ERASED-0002

Any erased file that has more than one directory extent may not recover
correctly where there is more than one instance of that file name in the
directory as it won't know which next extent belongs to each file.  In such
cases it is suggested to make a copy of the disk image and edit the file
manually using a hex editor and change the name entry to be unique and set
the User number to un-erase each extent.

Example:
Using 'cpmls' and the -F option:

Directory For Drive A:  User  0

    Name     Bytes   Recs   Attributes   Prot      Update          Create
------------ ------ ------ ------------ ------ --------------  --------------

MYFILE   TXT     4k     21              None   01/01/70 09:30  01/01/70 09:30
MYFILE   TXT     8k     58              None   01/01/70 09:30  01/01/70 09:30

Total Bytes     =     10k  Total Records =      79  Files Found =    2
Total 1k Blocks =      8   Used/Max Dir Entries For Drive A:    2/ 128

In the above "Files found = 2" and "Used Dir entries = 2".  This means each
file only used 1 directory extent.

Wildcard issues
---------------
Unix (and possibly Windows) based systems make use of command line globbing
which when referring to files on the CP/M disk is not desirable and causes
problems with wildcards (will pass matched files in host directory), if a
'u:' (a CP/M user number) is prefixed then it's not likely to be a problem,
to avoid the problem completely double quotes should be used.

When referring to host files the wildcard globbing action may be desirable.

From rev 2.10h patched cpmtools the wildcards "*.*" if used is replaced with
"*" to avoid problems with CP/M file name matching.  A "*.*" was only
matching names that had FILENAME.EXT but names that only had the FILENAME
part were not being found.  The use of "*" avoids that issue.

Windows and Linux
-----------------
Alternatively "-L dd dstep" should also work but you will need to specify
the double quotation marks.  Currently there is no error reporting for this
option so if it does not work then check you have the correct spelling. The
-L parameters are not case sensitive.

CP/M file location report
-------------------------
A feature has been added to allow the physical location of CP/M files to be
reported.  The 'cpmcp' program has been modified to make this possible. 
This option allows files to be checked against a 'ubeedisk .info' output
file.  Run 'cpmcp' for usage information.

To generate a report for all user areas on the disk would require each user
area to be reported separately.  There are 16 user areas numbered 0-15. 
This could be easily accomplished in a script or batch file where parameters
could be passed.  The output of 'cpmls' command could be used to see what
user areas contain files before requesting a report.

Example:

Microbee DS40 DSK disk image using LibDsk interface.  The parameter
'nowhere' can be anything but something has to be used here.  The '-r'
option tells 'cpmcp' to produce a report (no files are copied).  This option
relies on the 'heads' value being correct.  If the disk has more than one
head then an entry must be included in 'diskdefs' to allow reporting to
show the correct sides and cylinders.

>cpmcp -f ds40 -r -T dsk diskimage.dsk 0:*.* nowhere
>cpmcp -f ds40 -r -T dsk diskimage.dsk 1:*.* nowhere
>cpmcp -f ds40 -r -T dsk diskimage.dsk 2:*.* nowhere
.....
>cpmcp -f ds40 -r -T dsk diskimage.dsk 15:*.* nowhere

Error detection
---------------
From rev 2.10i patched-cpmtools now has error checking added to the 'libdsk'
driver interface (device_libdsk.c) for out of range tracks/sectors and
checking the results of read and write operations.  If an error occurs it
will exit with error code 1 to avoid segmentation issues and outputs some
information to give the user some idea of what went wrong.

As an example:

cpmls -F -f ds80 -T dsk ciab-ss80.dsk
patched-cpmtools error: Device_readSector(): head=0 cylinder=2 sector=22
Check "-f format" and all parameters are correct for this disk!

Here we told 'cpmls' that the disk is a Microbee 'ds80' format but it's
actually a Microbee CIAB 'ss80' format disk.  It is trying to read sector 22
which is the first (skewed) sector on a 'ds80' format disk but it won't
exist on a 'ss80' format disk.

To fix this issue change "-f ds80" to "-f ss80".

The error message may also be caused by a general read/write error on a
floppy or image disk.  Currently patched-cpmtools does not support
interactive retry methods, instead its recommended to make a disk image of
the floppy disk first using an appropriate tool such as 'ubeedisk' then use
patched-cpmtools on that disk image.

Most disk image errors will be caused by the use of incorrect command line
parameters or 'diskdefs' entry errors.

An error may also result from specifying an incorrect data rate option or
optionally the 'diskdefs' datarate parameter.

Usage examples
==============
Windows
-------
A Microbee DS40 40T floppy in a 1.2MB 80T HD 5.25" drive B:
List all files in 'user 0':
cpmls -f ds40 -T ntwdm -L dd -L dstep B: 0:*

A Microbee DS40 40T floppy in a 1.2MB 80T HD 5.25" drive B:
Copy all files in 'user 0' to dir 'temp':
cpmcp -f ds40 -T ntwdm -L dd -L dstep B: 0:* temp

A Microbee DS80 80T floppy in drive A:
Copy all files in dir 'temp' to 'user 0' (to floppy):
cpmcp -f ds80 -T ntwdm A: temp\* 0:

Note: Don't use trailing back slash characters in directory names, doing so
results in an error.

Linux
-----
A Microbee DS40 40T floppy in a 1.2MB 80T HD 5.25" drive /dev/fd1:
List all files in 'user 0':
cpmls -f ds40 -T floppy -L dd -L dstep /dev/fd1 0:*

A Microbee DS40 40T floppy in a 1.2MB 80T HD 5.25" drive /dev/fd1:
Copy all files in 'user 0' to dir 'temp':
cpmcp -f ds40 -T floppy -L dd -L dstep /dev/fd1 0:* temp

A Microbee DS80 80T floppy in drive /dev/fd0:
Copy all files in dir 'temp' to 'user 0' (to floppy):
cpmcp -f ds80 -T floppy /dev/fd0 temp/* 0:

Access to remote disks on your Microbee
---------------------------------------
The 'remote' disk type should allow reading/writing sectors over a serial
port to any floppy disk based Microbee Z80 computer (except Dreamdisk
model).

The FDS.COM program, sources and documentation containing some examples can
be found here:

http://www.microbee-mspp.org.au/repository

Look under 'Utilities/fds'.

Access to remote disks using a Floppyio
---------------------------------------
Floppyio is a floppy drive interface for reading and writing to MFM/FM disks
using 125, 150, 250, 300 and 500 kHz data rates over a USB serial interface.

For more information see:

http://www.microbee-mspp.org.au/forum/viewforum.php?f=47

Example to list files on a SS80 Microbee disk:

Linux:
cpmls -F -f ss80 -T remote serial:/dev/ttyACM0,115200-crtscts,a:

Windows:
cpmls -F -f ss80 -T remote serial:com3:,115200-crtscts,a:

'cpmcp' may be used to copy files to and from a floppy disk.  Accessing old
floppy disks should be avoided and should be archived and never written to.

Limitations
===========
Currently the Microbee Dreamdisk double sided disks are not likely to work
unless these are in raw image format. The Dreamdisk format uses bit 7 in the
head ID value to indicate a double sided disk.

A patched LibDsk will be required to allow this to work.  A patch for this
already exists but I need to see how to incorporate the changes. This will
be looked at in another cpmtools patch release.

Potential problems
==================
The following problems may be noticeable and may be caused by the operating
system, drivers, LibDsk or hardware.

LibDsk extension bytes 0x12, 0x13
---------------------------------
On standard CPCEMU DSK and EDSK disk images track header bytes at offsets
0x12 and 0x13 are unused and will be 0.

The LibDsk author added 2 bytes to the track header used in DSK and EDSK
disk images at offsets 0x12 and 0x13.  When accessing these disk images an
error may be result depending on what values patched-cpmtools passes for the
'FM' and 'datarate' values to LibDsk.

The values for the CPCEMU and LibDsk formats are documented here:

http://www.cpcwiki.eu/index.php/Format:DSK_disk_image_file_format

The value that is found at 0x13 is not directly related to the datarate
values used by patched-cpmtools rather it determines how LibDsk will access
the disk.  patched-cpmtools just passes the FM/MFM and data rate values onto
LibDsk.  patched-cpmtools does nothing with them.

A typical MFM, DD, DSK image created with the LibDsk library will contain
values 2 and 2 at track offsets 0x12 and 0x13.

An 8" FM, HD disk image will have values of 2 and 1.  To access these images
error free requires that the patched-cpmtools specifies "FM 1" and "datarate
0" or if the 'datarate' value is not in the definition then by using the "-L
hd" command line option to override.

cpmcp option '-r'
-----------------
When using the '-r' option in the 'cpmcp' command and the source media is a
floppy disk the reporting (even if redirected to a file) suffers from random
periods of inactivity (Ubuntu Hardy 2.6.24-19-generic i686).  Some systems
may be better than others.  Windows systems appears to work fine.

LibDsk and Linux
----------------
If this or other programs that use LibDsk are exited with ^C or for any
other reason while working with a floppy disk then upon re-running the
program the track position is incorrect and the program can't run correctly.

This problem can be observed with LibDsk's 'dskscan' program.  The problem may
be able to be reset by ejecting the disk, wait for 10 seconds and replacing
the disk and trying again.

If the above method does not work then eject the disk, wait 10 seconds,
replace the disk.  Now run the 'mdir' program from 'mstools'.  After a while
it will give up with an error but this seems to reset the disk system.  The
CP/M disk will probably work now.

This problem has been noticed on Ubuntu Hardy 2.6.24-19-generic i686.  Other
Linux systems may not be a problem.  Windows systems appears to work fine.

In general, Windows systems work better with LibDsk and floppy disks from my
own observations.

Disk image types
================
As of rev 2.10i LibDsk-1.4.0 supports a number of disk types.  Not all of
these will work or have been tried under the patched-cpmtools:

The following disc image file formats are supported by LibDsk. The ones
marked with an '*' are known to work.

dsk *
-----
Disc image in the DSK format used by CPCEMU. The format of a .DSK file is
described in the CPCEMU documentation.

edsk *
------
Disc image in the extended CPCEMU DSK format.

raw *
-----
Raw disc image - as produced by dd if=/dev/fd0 of=image.  On systems other
than Linux, DOS or Windows, this is also used to access the host system's
floppy drive.

logical
-------
Raw disc image in logical filesystem order.  Previous versions of LibDsk
could generate such images (for example, by using the now-deprecated
-logical option to dsktrans) but couldn't then write them back or use them
in emulators.

floppy *
--------
Host system's floppy drive (under Linux, DOS or Windows).

int25
-----
Hard drive partition under DOS. Also used for the floppy drive on Apricot
PCs.

ntwdm *
-------
Enhanced floppy support under Windows 2000 and XP, using an additional
kernel-mode driver. (Search for 'ntwdm' above)

myz80
-----
MYZ80 hard drive image, which is nearly the same as  raw but has a 256 byte
header.

cfi
---
Compressed floppy image, as produced by FDCOPY.COM under DOS.  Its format is
described in cfi.html.

imd *
-----
Disc images created by Dave Dunfield's ImageDisk utility.

jv3
---
Disc images used by Jeff Vavasour's TRS-80 emulators.

qm
--
Disc images created by Sydex's CopyQM. Write support in this driver is
experimental.

tele *
------
Disc images created by Sydex's TeleDisk. This is a read-only driver.

apridisk
--------
Disc image in the format used by the ApriDisk utility.  The format is
described in apridisk.html.

rcpmfs
------
Reverse CP/M file system. A directory is made to appear as a CP/M disk. 
This is an experimental system and should be approached with caution.

As of rev 2.10j the 'rcpmfs' should now work on most disk images as it now
forces the skew, skewstart, and datasect values to 1.

It may not be very useful under these tools for practical purposes but is
useful for testing that a host system directory has been correctly
configured with a 'rcpmfs' '.libdsk.ini' file to be used elsewhere such as
emulators.  This is documented in the LibDsk documentation.

Here is an example of a host directory configured as a Microbee SS80 disk:

Create a text file '.libdsk.ini' (note leading dot) in the directory that
will contain CP/M files and add the following to it:

[RCPMFS]
BlockSize=2048
DirBlocks=2
TotalBlocks=195
SysTracks=2
Version=2
Format=ss80
secbase=1

TotalBlocks = ((C * H - SysTracks) * bs * sectrk) / BlockSize
Where: C=cylinders, H=heads, bs=bytes per sector, sectrk=sectors per track

The above file may already exist and possibly created by another 3rd party
program as an auto generated file.  i.e: AutoCreated=name on the 2nd line
and a hashed '#' commented line above it stating it was auto generated.  The
'AutoCreated' value is not specified or used by LibDsk and it should just
ignore it.  It's used by other programs to auto generate the file so it
knows that it is not a manually created file and can overwrite it.

You may specify the format to use with 'Format' or alternatively set the
values independently (the # values are disabled)

The LibDsk documentation should be consulted for more information regarding
the 'rcpmfs' type.

remote *
--------
Remote LibDsk server, most likely at the other end of a serial line.
(Floppyio and FDS.COM on a Microbee)

ydsk
----
Disc image format used by the yaze and yaze-ag CP/M emulators.

Scripts
=======
In the distribution packages in the 'scripts' directory there are some shell
or batch file scripts depending on the package.  Run these without any
parameters for usage information.  What is provided may vary from release to
release.

Currently the scripts provided allow using the 'remote' type easier for
Floppyio and FDS.COM.  The Floppyio scripts are prefixed with 'f' and the
FDS.COM scripts with 'm'.

These scripts use the standard 'cpmtools' naming and will require editing if
using different prefixed executable names.

These scripts assume certain serial ports and will need to be edited if the
port is not correct.

Under Windows systems the 'm' prefixed scripts may also be used on a
Floppyio unit if the same serial port is being used for both.  The slower
19200 baud rate is ignored by Floppyio as it runs at maximum USB rate
regardless of the baud rate setting.

Building patched cpmtools
=========================
The patched-cpmtools is dependent on LibDsk being available and is needed
for all RAW and other disk image formats including floppy disks.

To build the 'fsed.cpm' utility in requires that an 'ncurses' development
package is installed on the system.  The 'cpmtools' configure script will
determine whether it exists.

The 'xxr' here represents the 'cpmtools' version (xx) and patch (r) revision
letter.

To build cpmtools-2.xx follow these directions (Ubuntu Hardy):

Make a new directory in your home account to work in:
$ mkdir cpmtools
$ cd cpmtools

Copy the cpmtools-2.xxr-ubee.patch file to this directory.

Untar the cpmtools-2.xx original tar distribution:
$ tar -xzf cpmtools-2.xx.tar.gz

Apply the patch file:
$ patch -p0 < cpmtools-2.xxr-ubee.patch

Copy the build.h file from the patch distribution
$ cp build.h cpmtools-2.xx

Build CP/M tools:
$ cd cpmtools-2.xx
$ ./configure OPTIONS
$ make

Install as user root with sudo or log in as root:
$ sudo make install
