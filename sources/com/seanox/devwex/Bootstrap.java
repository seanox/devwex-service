/**
 *  LIZENZBEDINGUNGEN - Seanox Software Solutions ist ein Open-Source-Projekt,
 *  im Folgenden Seanox Software Solutions oder kurz Seanox genannt.
 *  Diese Software unterliegt der Version 2 der Apache License.
 *
 *  Devwex, Advanced Server Development
 *  Copyright (C) 2017 Seanox Software Solutions
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not
 *  use this file except in compliance with the License. You may obtain a copy
 *  of the License at
 *  
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 *  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 *  License for the specific language governing permissions and limitations
 *  under the License.
 */
package com.seanox.devwex;

/**
 *  Bootstrap steuert den Server bei den Kommandos {@code start},
 *  {@code restart} und {@code stop} alternativ an. Was f&uuml;r einen sauberen
 *  Aufruf als Service mit der {@code prunsrv.exe} erforderlich ist.<br>
 *  <br>
 *  Bootstrap 5.0.0 20171203<br>
 *  Copyright (C) 2017 Seanox Software Solutions<br>
 *  Alle Rechte vorbehalten.
 *
 *  @author  Seanox Software Solutions
 *  @version 5.0.0 20171203
 */
public class Bootstrap {

    /**
     *  Haupteinsprung in die Anwendung.
     *  @param options Startargumente
     */
    public static void main(String[] options) {

        String string;

        string = "";
        if (options != null
                && options.length > 0)
            string = options[0];
        string = string.trim().toLowerCase();

        if (string.equals("start")) {
            Service.main(options);
        } else if (string.equals("restart")) {
            Service.restart();
        } else if (string.equals("stop")) {
            Service.destroy();
            System.exit(0);
        }
    }
}