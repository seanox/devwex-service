<p>
  <a>
    <img src="https://img.shields.io/badge/development-ended-lightgrey?style=for-the-badge">
  </a>
  <a>
    <img src="https://img.shields.io/badge/maintenance-ended-lightgrey?style=for-the-badge">
  </a>
  <a href="http://seanox.de/contact">
    <img src="https://img.shields.io/badge/support-active-green?style=for-the-badge">
  </a>
</p>


# Description
Service configures and uses Seanox Devwex as a Windows service.  
Seanox starts with the start of Windows, runs in the background and does not
require a user login.

__The project has been integrated into [Seanox Devwex](https://github.com/seanox/devwex)__
__and development in this repository has been ended.__  
__The respository is still available until the end of 2021 and will then be deleted.__



# Licence Agreement
Seanox Software Solutions ist ein Open-Source-Projekt, im Folgenden
Seanox Software Solutions oder kurz Seanox genannt.

Diese Software unterliegt der Version 2 der Apache License.

Copyright (C) 2020 Seanox Software Solutions

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at

http://www.apache.org/licenses/LICENSE-2.0  

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.


# System Requirement
- Microsoft Windows 7 or higher
- Java Runtime 8.x or higher


# Downloads
[Seanox Devwex Service 1.2.2.0](https://github.com/seanox/devwex-service/raw/master/releases/seanox-devwex-service-1.2.2.0.zip)
sources are included in the jar file


# Installation
Unpack the zip file into the directory of Seanox Devwex.  
Configure (if necessary) the file ``./devwex/program/service.bat``.  


# Usage
Open a command prompt as administrator.  
Go to the program directory ``./devwex/program`` and call ``service.bat install``.  
Use ``service.bat update`` to change and ``service.bat uninstall`` to remove the
service.

Control of the service in Windows (command prompt):  
Start: ``net start Devwex``  
Stop: ``net stop Devwex``


# Changes (Change Log)
## 1.2.2.0 20200905 (summary of the current version)  
BF: Project: Update from build script (clean up unused properties)  
BF: Project: Update of devwex.jar  
CR: Project: Update of the service.exe to prunsrv.exe 1.2.2  

[Read more](https://raw.githubusercontent.com/seanox/devwex-service/master/CHANGES)


# Contact
[Issues](https://github.com/seanox/devwex-service/issues)  
[Requests](https://github.com/seanox/devwex-service/pulls)  
[Mail](http://seanox.de/contact)


# Thanks!
<img src="https://raw.githubusercontent.com/seanox/seanox/master/sources/resources/images/thanks.png">

[JetBrains](https://www.jetbrains.com/?from=seanox)  
Sven Lorenz  
Andreas Mitterhofer  
[novaObjects GmbH](https://www.novaobjects.de)  
Leo Pelillo  
Gunter Pfannm&uuml;ller  
Annette und Steffen Pokel  
Edgar R&ouml;stle  
Michael S&auml;mann  
Markus Schlosneck  
[T-Systems International GmbH](https://www.t-systems.com)
