# SGC Construction Robot

Eigenständiger OpenComputers-Bauroboter für Minecraft 1.7.10. **Kein MATRIX-OS.**

## Benötigte Roboter-Komponenten

### Pflicht – damit der Roboter den Bau ausführen kann

| Komponente | Anzahl | Zweck |
|---|---:|---|
| **OpenComputers Roboter Tier 3** | 1 | Der eigentliche Bauroboter mit maximalem Inventar-/Upgrade-Ausbau |
| **Tier-3 Akku** | 1+ | Energieversorgung des Roboters; für große Bauabschnitte möglichst hohe Kapazität |
| **Inventory Controller Upgrade** | 1 | Liest Inventarslots/Itemstacks, erkennt Werkzeuge und unterstützt Werkzeugwechsel |
| **Werkzeug/Spitzhacke** | 1+ | Zum Abbauen von Blöcken, wenn der Bauplatz vorbereitet werden muss oder Hindernisse entfernt werden müssen |
| **Baumaterial** | nach Schematic | Alle benötigten Blöcke müssen dem Roboter bzw. der Materialkiste zur Verfügung stehen |
| **Ladeeinrichtung** | 1 | Fester Ladepunkt, an dem der Roboter zwischen Bauabschnitten Energie nachladen kann |
| **OpenComputers-Kompatibles Lade-/Versorgungssystem** | 1 | Muss zum verwendeten OC-Setup passen |

### Sehr empfohlen – für den automatischen Dauerbetrieb

| Komponente | Anzahl | Zweck |
|---|---:|---|
| **Chunk Loader Upgrade** | 1 | Hält den Arbeitsbereich geladen, damit der Roboter beim automatischen Bau nicht durch Chunk-Unload stehen bleibt |
| **Navigation Upgrade** | 1 | Zusätzliche Positions-/Navigationsinformationen für komplexe Bauabläufe |
| **Geolyzer Upgrade** | 1 | Erkennt Blöcke/Terrain vor dem Roboter und hilft bei Sicherheits- und Plausibilitätsprüfungen |
| **Wireless Network Card / Modem** | 1 | Fernstatus, Meldungen und optionale Steuerung |
| **Data Card** | 1 | Optional für zusätzliche lokale Datenverarbeitung; nicht für den Grundbetrieb erforderlich |

## Werkzeugausrüstung

Der Roboter soll **nicht auf eine bestimmte Vanilla-Spitzhacke festgelegt** sein.

Geeignet sind unter anderem:

- Eisen-Spitzhacke
- Diamant-Spitzhacke
- Netherite-Spitzhacke, falls durch das verwendete Modpack vorhanden
- modded Spitzhacken
- Tinkers' Construct Pickaxe
- Tinkers' Construct Hammer/Mattock/Excavator, sofern vom verwendeten Setup als Itemstack erkannt
- andere Werkzeuge, die OpenComputers über den Inventory Controller erkennen kann

Für die Werkzeugerkennung werden Itemname/Label und die vom Inventory Controller gelieferten Itemdaten verwendet. Dadurch kann der Roboter das vorhandene Werkzeug auswählen, ohne eine einzige feste Pickaxe-ID vorauszusetzen.

## Material- und Abfalllager

Zusätzlich zum Roboter selbst wird **mindestens eine Material-/Versorgungskiste** am Start-/Versorgungspunkt benötigt.

Empfohlen:

- 1 Kiste/Container für Baumaterial
- 1 Kiste/Container für Abfall und nicht benötigte Items
- optional getrennte Kisten für häufig benötigte Blockgruppen

Der Roboter soll sein Inventar regelmäßig leeren bzw. Material nachfüllen, damit der Bau nicht wegen eines vollen Inventars stoppt.

## Start- und Ladepunkt

Der Ladepunkt muss dauerhaft erreichbar sein.

Der Bereich um die konfigurierte Startposition wird standardmäßig mit einem **Radius von 5 Blöcken geschützt**. Dort darf der Roboter keine normalen Bauarbeiten ausführen. Dadurch bleiben Ladeposition, Rückkehrweg und Versorgungskisten frei.

Empfohlene Anordnung:

```text
          Arbeitsbereich
               ↓
        ┌───────────────┐
        │               │
        │   SGC-Bau     │
        │               │
        └───────┬───────┘
                │
        5 Block Schutzbereich
                │
        [Ladepunkt/Roboter]
        [Materialkiste]
        [Abfallkiste]
```

## Inventar des Roboters

**Slot 1** bleibt standardmäßig für das Hauptwerkzeug reserviert.

Die übrigen Slots können für Baumaterial verwendet werden. Der Builder darf reservierte Werkzeug-/Systemslots nicht ungefragt als normalen Materialspeicher verwenden.

Für große SGC-Bauten ist deshalb ein externes Materiallager sinnvoller als ausschließlich das Roboterinventar.

## Was wirklich nötig ist

Wenn du nur testen möchtest, ob der Roboter grundsätzlich bauen kann, reicht:

1. Tier-3 Roboter
2. ausreichend Akku/Energie
3. Inventory Controller Upgrade
4. mindestens ein passendes Werkzeug
5. die benötigten Baumaterialien
6. ein erreichbarer Ladepunkt
7. ein vorbereiteter Bauplan

Für den **vollautomatischen SGC-Dauerbau** empfehle ich zusätzlich:

1. Chunk Loader Upgrade
2. Navigation Upgrade
3. Geolyzer Upgrade
4. Wireless Network Card/Modem
5. Materialkiste
6. Abfallkiste
7. Ersatzwerkzeug
8. große Energiereserve

## Was nicht zwingend benötigt wird

Nicht erforderlich für den Grundbetrieb sind beispielsweise:

- MATRIX-OS
- ein zweiter Computer
- ein Monitor am Roboter
- eine Tastatur am Roboter
- eine Internetverbindung
- ein bestimmtes Pickaxe-Modell

Der Roboter läuft als eigenständiger OpenComputers-Bauroboter.

## Aktueller Softwareaufbau

- `sgc-builder.lua` – Hauptprogramm, Resume/Progress und Bauablauf
- `schematic.lua` – validiert den portablen `.plan`-Bauplan
- `navigation.lua` – Positions- und Richtungsverwaltung
- `inventory.lua` – Inventar, Materialsuche und Pick-/Tool-Erkennung
- `recovery.lua` – Neustart-/Abbruchfortsetzung
- `config.cfg` – Schutzradius, Slots und Pfade

## Bauplanformat

Der Roboter erwartet einen validierten Lua-Bauplan, z. B. `/home/sgc/SGC-SG1-Cheyenne-Mountain.plan`, der mit `return { ... }` eine Tabelle liefert.

```lua
return {
  width = 10, height = 5, length = 10,
  blocks = {
    {x = 6, y = 1, z = 0, sx = 5, sy = 1, sz = 0, face = 0, slot = 2},
  }
}
```

`x/y/z` beschreiben das Zielblockvolumen. `sx/sy/sz` und `face` werden vom Plan-Compiler verwendet, damit der Roboter einen Block von einer erreichbaren Seite setzen kann.

## Schematic-Unterstützung

Das Repository kann `.schematic`/`.schem` als Quellformat verwenden. Die Binär-NBT-/GZIP-Konvertierung sollte vor dem Robotereinsatz in den portablen `.plan`-Datensatz erfolgen, weil OpenComputers 1.7.10 nicht auf jeder Installation dieselbe GZIP/NBT-Laufzeitbibliothek bereitstellt.

Die finale filmnahe SGC-Schematic wird **nicht erfunden oder als fertig bezeichnet**, solange die Referenzgeometrie nicht validiert und die Binärdatei technisch geprüft wurde.
