# SGC Construction Robot

Eigenständiger OpenComputers-Bauroboter für Minecraft 1.7.10. **Kein MATRIX-OS.**

## Aktueller Stand

Der Roboterkern ist jetzt modular aufgebaut:

- `sgc-builder.lua` – Hauptprogramm, Resume/Progress und Bauablauf
- `schematic.lua` – validiert den portablen `.plan`-Bauplan
- `navigation.lua` – Positions- und Richtungsverwaltung
- `inventory.lua` – Inventar, Materialsuche und Pick-/Tool-Erkennung
- `recovery.lua` – Neustart-/Abbruchfortsetzung
- `config.cfg` – Schutzradius, Slots und Pfade

## Werkzeugerkennung

Der Roboter erkennt Werkzeuge über die OpenComputers Inventory Controller-Daten und berücksichtigt Namen/Labels wie `pickaxe`, `hammer`, `excavator`, `mattock` und `pick`. Dadurch können auch modded Werkzeuge (z. B. Tinkers-Werkzeuge) verwendet werden, sofern OpenComputers sie über den Inventory Controller als Itemstack liefert.

## Start-/Ladepunkt

Der Bereich um `START_X/Y/Z` ist standardmäßig mit einem **Radius von 5 Blöcken geschützt**. Der Builder verwendet ihn nicht als Baufläche. `RESERVED_SLOTS` schützt standardmäßig Slot 1 für das Hauptwerkzeug.

## Bauplanformat

Der Roboter erwartet einen validierten Lua-Bauplan, z. B. `/home/sgc/SGC-SG1-Cheyenne-Mountain.plan`, der mit `return { ... }` eine Tabelle liefert:

```lua
return {
  width = 10, height = 5, length = 10,
  blocks = {
    -- sx/sy/sz = Standposition des Roboters; face = 0..3.
    {x = 6, y = 1, z = 0, sx = 5, sy = 1, sz = 0, face = 0, slot = 2},
  }
}
```

`x/y/z` beschreiben das Zielblockvolumen. `sx/sy/sz` und `face` werden vom Plan-Compiler verwendet, damit der Roboter einen Block von einer erreichbaren Seite setzen kann. So muss der Roboter nicht in den gerade gebauten Block laufen.

## Schematic-Unterstützung

Das Repository kann weiterhin `.schematic`/`.schem` als Quellformat verwenden. Die eigentliche Binär-NBT-/GZIP-Konvertierung sollte vor dem Robotereinsatz in den portablen `.plan`-Datensatz erfolgen. Das ist absichtlich so, weil OpenComputers nicht auf jeder 1.7.10-Installation eine einheitliche GZIP/NBT-Laufzeitbibliothek bereitstellt.

Die finale filmnahe SGC-Schematic wird **nicht erfunden oder als fertig bezeichnet**, solange die Referenzgeometrie nicht validiert und die Binärdatei technisch geprüft wurde.
