@echo off

  rem Seanox Devwex is started from working directory ./devwex/program.
  rem Here, following variables are used:
  rem
  rem   name Service name (spaces/special characters are not allowed)
  rem
  rem   text Service display name (maximum 1024 characters)
  rem
  rem   note Service description (maximum 1024 characters)
  rem
  rem   jvms Initial memory pool size in MB
  rem
  rem   jvmx Maximum memory pool size in MB
  rem
  rem   home Working path (optionaly)
  rem
  rem   java Java environment path (optionaly)
  rem
  rem   jdwp Options for remote debugging (optional)
  rem
  rem To configure see marked 'parts of configuration' (line 37/109/154).
  rem
  rem   link to used prunsrv.exe (alias service-32.exe/service-64.exe):
  rem     http://commons.apache.org/daemon/procrun.html

  set name=Devwex
  set text=Seanox Devwex
  set note=Seanox Advanced Server Development

  rem NOTE - If environment variables "home" and "java" empty or not defined,
  rem this will be resolved automatically. The declaration of both values is
  rem optional.

rem -- PART OF CONFIGURATION ---------------------------------------------------

  set home=%cd%
  set java=
  
  rem set home=C:\Program Files\Devwex\program
  rem set java=C:\Program Files\Java
  rem set jdwp=dt_socket,server=y,suspend=n,address=8000
  rem set jvms=256
  rem set jvmx=512

rem ----------------------------------------------------------------------------
  
  if "%1" == "-install"   goto install
  if "%1" == "-update"    goto install
  if "%1" == "-uninstall" goto uninstall

  echo usage: service.bat [command]
  echo.
  echo   -install
  echo   -update
  echo   -uninstall
  
  goto:eof

:install

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
    echo ERROR - Java Runtime Environment not found
    goto:eof
  )

  if not exist "%home%\%service%" (
    echo.
    echo ERROR - Service Runtime ^(%service%^) not found
    goto:eof
  )

  if not exist "%home%\service.jar" (
    echo.
    echo ERROR - Service Runtime ^(service.jar^) not found
    goto:eof
  )

  set service=service-32.exe
  if exist "%PROCESSOR_ARCHITECTURE:~-2,2%" == "64" (
      set service=service-64.exe
  )

rem -- PART OF CONFIGURATION ---------------------------------------------------

  set init=--DisplayName "%text%"
  set init=%init% --Description "%note%"
  set init=%init% --Startup auto
  set init=%init% --Install "%home%\%service%"
  set init=%init% --Jvm "%jvm%"

  set init=%init% --Classpath service.jar;devwex.jar
  set init=%init% --StdOutput %home%/../storage/service.log
  set init=%init% --StdError %home%/../storage/service.log

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

  if not "%jvms%" == "" set init=%init% --JvmMs=%jvms%
  if not "%jvmx%" == "" set init=%init% --JvmMx=%jvmx%

  if "%1" == "-update" %service% //DS//%name%

  %service% //IS//%name% %init%

  set classpath=
  set javapath=
  set librariespath=
  set options=
  set systempath=%path%
  set registry=

  for %%i in (../runtime/scripts/*.bat ../runtime/scripts/*.cmd) do call ../runtime/scripts/%%i
  
rem -- PART OF CONFIGURATION ---------------------------------------------------

  %service% //US/%name% ++JvmOptions='-Dpath="%systempath%;"'
  %service% //US/%name% ++JvmOptions='-Dsystemdrive=%systemdrive%'
  %service% //US/%name% ++JvmOptions='-Dsystemroot=%systemroot%'
  %service% //US/%name% ++JvmOptions='-Dlibraries="..\libraries;%librariespath%;"'
  
  if "%jdwp%" == "" goto:eof

  %service% //US/%name% ++JvmOptions='-Xdebug'
  %service% //US/%name% ++JvmOptions='-Xnoagent'
  %service% //US/%name% ++JvmOptions='-Djava.compiler=NONE'
  %service% //US/%name% ++JvmOptions='-Xrunjdwp:transport="%jdwp%"'

  goto:eof

:uninstall

  set service=service-32.exe
  if exist "%PROCESSOR_ARCHITECTURE:~-2,2%" == "64" (
    set service=service-64.exe
  )
  %service% //DS//%name%
  goto:eof