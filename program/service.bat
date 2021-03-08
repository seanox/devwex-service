  @echo off

  rem Seanox Devwex is started from working directory ./devwex/program.
  rem Here, following variables are used:
  rem
  rem     name - Service name (spaces/special characters are not allowed)
  rem
  rem     text - Service display name (maximum 1024 characters)
  rem
  rem     note - Service description (maximum 1024 characters)
  rem
  rem     jvms - Initial memory pool size in MB
  rem
  rem     jvmx - Maximum memory pool size in MB
  rem
  rem     home - Working path (optional)
  rem
  rem     java - Java environment path (optional)
  rem
  rem     jdwp - Options for remote debugging (optional)
  rem
  rem To configure see marked 'parts of configuration' (line 37/109/154).
  rem
  rem     link to used prunsrv.exe (alias service-32.exe/service-64.exe):
  rem         http://commons.apache.org/daemon/procrun.html

  rem NOTE - If environment variables "home" and "java" empty or not defined,
  rem this will be resolved automatically. The declaration of both values is
  rem optional.

  echo Seanox Devwex Service [Version #[ant:release-version] #[ant:release-date]]
  echo Copyright (C) #[ant:release-year] Seanox Software Solutions
  echo Advanced Server Development
  echo.

  cd /D "%~dp0"
  set home=%CD%

  SetLocal EnableDelayedExpansion

rem -- PART OF CONFIGURATION ---------------------------------------------------

  set name=Devwex
  set text=Seanox Devwex
  set note=Seanox Advanced Server Development
  set user=NetworkService

  set home=%cd%
  set java=

  rem set home=C:\Program Files\Devwex\program
  rem set java=C:\Program Files\Java
  rem set jdwp=dt_socket,server=y,suspend=n,address=8000
  rem set jvms=256
  rem set jvmx=512

rem ----------------------------------------------------------------------------

  if "%1" == "install"   goto install
  if "%1" == "update"    goto install
  if "%1" == "uninstall" goto uninstall

  echo usage: service.bat [command]
  echo.
  echo    install
  echo    update
  echo    uninstall
  net session >nul 2>&1
  if not %errorLevel% == 0 (
    echo.
    echo This script must run as Administrator.
  )
  exit /B 0

:install

  set label=INSTALL
  if "%1" == "update" set label=UPDATE

  echo %label%: Detection of Java runtime environment
  if "%java%" == "" (
    if exist "%home%\..\runtime\java" set java=%home%\..\runtime\java
  )
  if "%java%" == "" (
    if not "%java_home%" == "" set java=%java_home%
  )
  if "%java%" == "" (
    for %%i in ("%path%") do (
      if exist %%i\java.exe set java=%%i\..
    )
  )
  set jvm=
  if exist "%java%\bin\client\jvm.dll" set jvm=%java%\bin\client\jvm.dll
  if exist "%java%\bin\server\jvm.dll" set jvm=%java%\bin\server\jvm.dll
  if exist "%java%\jre\bin\client\jvm.dll" set jvm=%java%\jre\bin\client\jvm.dll
  if exist "%java%\jre\bin\server\jvm.dll" set jvm=%java%\jre\bin\server\jvm.dll
  if not exist "%jvm%" (
    echo.
    echo ERROR: Java Runtime Environment not found
    exit /B 0
  )
  for %%i in ("%jvm%") do echo    %%~fi

  echo %label%: Detection of bootstrap package
  if not exist "%home%\service.jar" (
    echo.
    echo ERROR: Service Runtime ^(service.jar^) not found
    exit /B 0
  )
  for %%i in ("%home%\service.jar") do echo    %%~fi

  echo %label%: Detection of service runner
  set service=service-32.exe
  if exist "%PROCESSOR_ARCHITECTURE:~-2,2%" == "64" (
      set service=service-64.exe
  )
  if not exist "%home%\%service%" (
    echo.
    echo ERROR: Service runner ^(%service%^) not found
    exit /B 0
  )
  for %%i in ("%home%\%service%") do echo    %%~fi

rem -- PART OF CONFIGURATION ---------------------------------------------------

  set init=--DisplayName "%text%"
  set init=%init% --Description "%note%"
  set init=%init% --Startup auto
  set init=%init% --Install "%home%\%service%"
  set init=%init% --Jvm "%jvm%"

  set init=%init% --Classpath service.jar;devwex.jar
  set init=%init% --StdOutput "%home%/../storage/output.log"
  set init=%init% --StdError "%home%/../storage/error.log"

  set init=%init% --LogPath "%home%/../storage"
  set init=%init% --LogPrefix service

  set init=%init% --StartPath "%home%"
  set init=%init% --StartMode jvm
  set init=%init% --StartClass com.seanox.devwex.Bootstrap
  set init=%init% --StartMethod main
  set init=%init% --StartParams start

  set init=%init% --StopPath "%home%"
  set init=%init% --StopMode jvm
  set init=%init% --StopClass com.seanox.devwex.Bootstrap
  set init=%init% --StopMethod main
  set init=%init% --StopParams stop

rem ----------------------------------------------------------------------------

  set lastError=
  set lastError=%errorLevel%

  rem Full access for the NetworkService another user to the AppDirectory
  rem Here no directory of a user should be used, because it is not clear
  rem whether the directory is accessible without the login.
  echo %label%: Grant all privileges for %user% to the app AppDirectory
  for %%i in ("%home%\..") do echo    %%~fi
  icacls.exe "%home%\.." /grant %service_account%:(OI)(CI)F /T /Q
  if not "%lastError%" == "%errorLevel%" goto error

  if not "%jvms%" == "" set init=%init% --JvmMs=%jvms%
  if not "%jvmx%" == "" set init=%init% --JvmMx=%jvmx%

  sc query %name% >nul 2>&1
  if "%errorLevel%" == "%lastError%" (
    echo %label%: Service is still present and will be stopped and removed
    %service% //DS//%name%
  )

  echo %label%: Service will be created

  %service% //IS//%name% %init%

  sc config %name% obj="NT Authority\%user%x" >%~n0.log
  if not "%errorLevel%" == "%lastError%" goto error

  set classpath=
  set javapath=
  set librariespath=
  set options=
  set systempath=%path%
  set registry=

  set extensions=false
  echo %label%: Search for runtime extensions
  for %%i in (../runtime/*.bat ../runtime/*.cmd) do (
    set extensions=true
    echo    %%~fi
    call ../runtime/%%i
  )
  if "%extensions%" == "false" echo    nothing found

rem -- PART OF CONFIGURATION ---------------------------------------------------

  echo %label%: Service will be final configured

  %service% //US/%name% ++JvmOptions='-Dpath="%systempath%;"'
  %service% //US/%name% ++JvmOptions='-Dsystemdrive=%systemdrive%'
  %service% //US/%name% ++JvmOptions='-Dsystemroot=%systemroot%'
  %service% //US/%name% ++JvmOptions='-Dlibraries="..\libraries;%librariespath%;"'

  if not "%jdwp%" == "" (
    %service% //US/%name% ++JvmOptions='-Xdebug'
    %service% //US/%name% ++JvmOptions='-Xnoagent'
    %service% //US/%name% ++JvmOptions='-Djava.compiler=NONE'
    %service% //US/%name% ++JvmOptions='-Xrunjdwp:transport="%jdwp%"'
  )

  echo %label%: Successfully completed
  exit /B 0

:uninstall

  set label=UNINSTALL

  echo %label%: Detection of service runner
  set service=service-32.exe
  if exist "%PROCESSOR_ARCHITECTURE:~-2,2%" == "64" (
      set service=service-64.exe
  )
  if not exist "%home%\%service%" (
    echo.
    echo ERROR: Service runner ^(%service%^) not found
    exit /B 0
  )
  for %%i in ("%home%\%service%") do echo    %%~fi

  sc query %name% >nul 2>&1
  if "%errorLevel%" == "0" (
    echo %label%: Service is still present and will be stopped and removed
    %service% //DS//%name%
  ) else echo %label%: Service has already been removed

  echo %label%: Successfully completed
  exit /B 0

:error

  echo.
  echo ERROR: An unexpected error occurred.
  echo ERROR: The script was canceled.

  if not exist %~n0.log exit /B 0

  echo.
  type %~n0.log & del %~n0.log

  exit /B 0
