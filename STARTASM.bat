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
    ping %dev-nm%
    cls
    if %ERRORLEVEL% NEQ 0 (cd err &start noping.vbs &cd.. &goto mn-menu /b 1) 
    echo Online
    echo.
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
    if %userin% == B goto devping
    if %userin% == b goto devping

:ad-coms
cls

echo ADCreate  %time%  %date%  Client:%whoami%
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

          echo ADCreate  %time%  %date%  Client:%whoami%
          echo =============================================
          echo.
          echo Please enter a username:
          echo NOTE: It is reccomended the username does
          echo not contain a space
          echo.

          set /p un-name=
            powershell New-ADUser %un-name% -AccountPassword (ConvertTo-SecureString -AsPlainText “Temporary1!” -Force) -ChangePasswordAtLogon $True 
            ::implemented this in the adpwdrst application, this will tell the user if the computer is either a not connected to a domain or b the computer where ASM is run on does not have valid permissions to do so or, ad is not being run on it.
            if %ERRORLEVEL% NEQ 0 (echo The application has detected an unknown error and must close. This may be caused by the specified server not being connected to a domain network. &pause &exit/b 1) 
          
          cls
                echo ADCreate  %time%  %date%  Client:%whoami%
                echo =============================================
                echo.
                echo Done, user %un-name% created. Details 
                echo displayed below:
                echo.
                echo Username: %un-name%
                echo Password: Temporary1!
                echo.
                echo Further details such as users department can
                echo only be changed manually for the time being.
                echo.
                echo This feature may become available in later 
                echo builds
                echo.
                pause
        
            echo ADCreate  %time%  %date%  Client:%whoami%
            echo =============================================
            echo.
            echo What would you like to do now?
            echo.
            echo A. Create another user account
            echo B. Return to main menu
            echo.
            
            set /p adinput=Option:
            if %adinput% == A goto adcrt
            if %adinput% == a goto adcrt
            if %adinput% == B goto mn-menu
            if %adinput% == b goto mn-menu




      :adpwdrst
      cls
      echo AD-PWD-CONT  %time%  %date%  Client:%whoami%
      echo =============================================
      echo.
      echo Please enter the account name for the 
      echo password that needs to be reset:
      echo.
      set /p adpwdinput=Username:
        powershell Import-Module ActiveDirectory Set-ADAccountPassword -Identity %adpwdinput% -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Temporary1!" -Force)
        ::command as mentioned earlier
        if %ERRORLEVEL% NEQ 0 (echo The application has detected an unknown error and must close. This may be caused by the specified server not being connected to a domain network. &pause &exit/b 1)

      cls 
                echo AD-PWD-CONT  %time%  %date%  Client:%whoami%
                echo =============================================
                echo.
                echo Done, user %un-name% password has
                echo been reset. Details displayed below:
                echo.
                echo Username: %un-name%
                echo Password: Temporary1!
                echo.
                pause 

            echo AD-PWD-CONT  %time%  %date%  Client:%whoami%
            echo =============================================
            echo.
            echo What would you like to do now?
            echo.
            echo A. Reset another password
            echo B. Return to main menu
            echo.
            
            set /p adinput=Option:
            if %adinput% == A goto adpwdrst
            if %adinput% == a goto adpwdrst
            if %adinput% == B goto mn-menu
            if %adinput% == b goto mn-menu        







        



      




