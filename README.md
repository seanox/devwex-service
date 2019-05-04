# Description
Service configures and uses "Seanox Devwex" as a Windows service.  
The service can be set to automatically start when the machine boots and will
continue to run with no user logged onto the machine.


# Licence Agreement
Seanox Software Solutions ist ein Open-Source-Projekt, im Folgenden
Seanox Software Solutions oder kurz Seanox genannt.

Diese Software unterliegt der Version 2 der Apache License.

Copyright (C) 2019 Seanox Software Solutions

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
[Seanox Devwex Service 1.1.0.1](https://github.com/seanox/devwex-service/raw/master/releases/seanox-devwex-service-1.1.0.1.zip)
sources are included in the jar file


# Installation
Unpack the zip file into the directory of Seanox Devwex.  
Configure (if necessary) the file ``./devwex/program/service.bat``.  
Open a command prompt as administrator.  
Go to the program directory ``./devwex/program`` and call ``servcie.bat -install``.  
Use ``servcie.bat -update`` to change and ``servcie.bat -uninstall`` to remove the
service.

Control of the service in Windows (command prompt):
Start: ``net start Devwex``  
Stop: ``net stop Devwex``


# Changes (Change Log)
## 1.1.0.1 20190504 (summary of the current version)  
BF: Correction of batch file  
BF: Build: Correction of the integration of the release notes  
CR: Project: Uniform use of ./LICENSE and ./CHANGES  
CR: Project: Automatic update of the version in README.md  

[Read more](https://raw.githubusercontent.com/seanox/devwex-service/master/CHANGES)


# Contact
[Support](http://seanox.de/contact?support)  
[Development](http://seanox.de/contact?development)  
[Project](http://seanox.de/contact?service)  
[Page](http://seanox.de/contact)  


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
