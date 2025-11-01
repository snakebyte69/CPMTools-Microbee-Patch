:: List files on a floppy disk in a Microbee unit running FDS.COM.
:: This assumes it is connected as 'com3:'.

@echo off

set format=%1
set drive=%2

if %format%.==. goto usage
if %drive%.==. goto usage

cpmls -F -f %format% -T remote serial:com3:,19200-crtscts,%drive%:
goto done

:usage
echo Purpose: List files on a floppy disk in a Floppyio unit.
echo Usage  : %0 format drive
echo Example: %0 ss80 a
goto done

:done
