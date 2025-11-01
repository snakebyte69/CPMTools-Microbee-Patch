::==============================================================================
:: Install script for Windows systems.
::
:: The script will install the binary files.  It takes 1 or 2 parameters. If
:: only 1 parameter is given then it is the destination location to install
:: to.  If 2 parameters given then the second parameter determines if the
:: binaries should be prefixed with the letter 'p'.  This may be used so that
:: the tools can co-exist with an unpatched 'cpmtools'.
::
:: The install.bat script needs to be in the same directory where the 'tools'
:: directory is located.
::
:: Usage examples:
::
:: install.bat \path\to\destination
:: install.bat \path\to\destination prefix
::==============================================================================

@echo off

set destination=%1
set prefix=%2

if %destination%.==. goto usage
if %prefix%.==. goto noprefix
if %prefix%.==prefix. goto prefix
goto usage

:prefix
set prefix=p
goto makedir

:noprefix
set prefix=
goto makedir

:makedir
:: create the destination directory if it does not exist
if exist %destination% goto install
mkdir %destination%

:install
:: install the list of files
for %%f in (cpmls cpmcp cpmrm cpmchmod cpmchattr mkfs.cpm fsck.cpm fsed.cpm diskdefs) do (
   if %%f==diskdefs (
      echo Installing %%f as %%f%prefix%
      copy /Y /B .\tools\%%f %destination%\%%f%prefix%
   ) else (
      echo Installing %%f.exe as %prefix%%%f.exe
      copy /Y /B .\tools\%%f.exe %destination%\%prefix%%%f.exe
   )
)
goto done

:usage
echo Installs patched-cpmtools binary files with or without a prefix
echo.
echo %0 destination_path
echo %0 destination_path prefix
echo.
echo Usage examples:
echo %0 \path\to\destination
echo %0 \path\to\destination prefix
echo.
echo Where 'prefix' is specified the prefix will be 'p' otherwise is not used.

:done
