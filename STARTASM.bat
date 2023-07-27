@echo off
color 71
batbox /h 0

::allows debugging, will remove in release version
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:mn-menu
cls

echo Main menu  %time%  %date%  Client:%whoami%
echo =============================================
echo.
echo 1 Ping Devices
echo 2 AD Tools
echo 3 Exit

set /p input= Option:
  if %input% == 1 goto devping
  if %input% == 2 goto ad-coms



:: Allows an admin to check a device to see if it is connected to the network
:devping
cls

echo Main menu  %time%  %date%  Client:%whoami%
echo =============================================
echo.
echo Please enter the clients host name, for
echo example: %whoami% is your device name.
echo.

:: gets admin to input host name
set /p dev-nm= Host name:

:: uses input to ping host
    echo %dev-nm%:
    ping -n %dev-nm% | find "TTL=" >nul
        if errorlevel 1 (
          echo Offline - Please check on device
        ) else (
          echo Online
        )

pause

::asks the user for further input on next task
cls
echo.
echo What would you like to do now?
echo    A - Return to menu
echo    B - Ping another device
echo.

set /p userin= 
    if %userin% == A goto mn-menu
    if %userin% == a goto mn-menu
    if %userin% == B goto dev-ping
    if %userin% == b goto dev-ping

:ad-coms
cls

echo Main menu  %time%  %date%  Client:%whoami%
echo =============================================
echo.
echo Please select a function:
echo.
echo 1 - Create an AD user
echo 2 - Reset an AD password
echo 3 - Return to menu
echo.

    set /p adinf=
      if %adinf% == 1 goto adcrt
      if %adinf% == 2 goto adpwdrst
      if %adinf% == 3 goto mn-menu

      :adcrt
      cls

      echo Main menu  %time%  %date%  Client:%whoami%
      echo =============================================
      echo.
      echo Please enter a username:
      echo NOTE: It is reccomended the username does
      echo not contain a space
      echo.

      set /p un-name=
        $splat = @{
         Name = '%un-name%'
         AccountPassword = (Read-Host -AsSecureString 'AccountPassword')
         Enabled = $true
        }
          New-ADUser @splat


      




