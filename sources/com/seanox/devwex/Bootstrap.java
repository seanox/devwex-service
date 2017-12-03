/**
 *  LIZENZBEDINGUNGEN - Seanox Software Solutions ist ein Open-Source-Projekt,
 *  im Folgenden Seanox Software Solutions oder kurz Seanox genannt.
 *  Diese Software unterliegt der Version 2 der GNU General Public License.
 *
 *  Devwex, Advanced Server Development
 *  Copyright (C) 2017 Seanox Software Solutions
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of version 2 of the GNU General Public License as published
 *  by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
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