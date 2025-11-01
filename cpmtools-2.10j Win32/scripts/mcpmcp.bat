:: Copy files from a floppy disk in a Microbee unit running FDS.COM to the local file system.
:: This assumes it is connected as 'com3:'.

@echo off

set format=%1
set drive=%2
set files=%3
set topath=.\

if %format%.==. goto usage
if %drive%.==. goto usage
if %files%.==. goto usage

if %4%.==. goto copy
set topath=%4%
mkdir %topath%

:copy
cpmcp -f %format% -T remote serial:com3:,19200-crtscts,%drive%: %files% %topath%
goto done

:usage
echo Purpose: Copy files from a floppy disk in a Floppyio unit.
echo Usage  : %0 format drive files [to_path]
echo Example: %0 ss80 a 0:*.*
goto done

:done
