# SGC Construction Robot

Eigenständiger OpenComputers-Bauroboter für Minecraft 1.7.10.

Dieses System benötigt **kein MATRIX-OS**. Es ist für OpenComputers/OpenOS ausgelegt und arbeitet als eigener SGC-Bau-Client.

## Ziel

Der Roboter soll einen vorbereiteten SGC-Bauplan blockweise ausführen, Material und Werkzeuge verwalten, den Fortschritt speichern und nach einem Neustart fortsetzen können.

## Geplante Dateien

- `sgc-builder.lua` – Hauptprogramm
- `schematic.lua` – Bauplan-Reader
- `inventory.lua` – Inventarverwaltung
- `navigation.lua` – Bewegung und Positionsverwaltung
- `materials.lua` – Materialprüfung
- `recovery.lua` – Wiederaufnahme nach Abbruch
- `config.cfg` – Roboterkonfiguration

## Wichtig

Die endgültige SGC-`.schematic` wird erst eingecheckt, wenn die Referenzgeometrie vorliegt und die erzeugte Datei technisch validiert wurde. Es wird keine erfundene oder leere Schematic als fertige SGC-Datei ausgegeben.
