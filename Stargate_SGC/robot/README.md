# SGC Construction Robot

Eigenständiger OpenComputers-Bauroboter für Minecraft 1.7.10. **Kein MATRIX-OS.**

Der Roboter ist ausschließlich für das Projekt `Stargate_SGC` im Repository `xDarkixx/schematiken-` vorgesehen.

## 1. Was wird benötigt?

### Pflicht

- Minecraft **1.7.10**
- **OpenComputers** für Minecraft 1.7.10
- 1x **OpenComputers Robot**
- mindestens ein brauchbarer **Akku** für den Robot
- genügend RAM für OpenOS und das Builder-Programm
- ein **Inventory Controller Upgrade** für Werkzeug-/Item-Erkennung und Inventarverwaltung
- ein **geprüftes Lade-/Charging-System**, damit der Roboter zwischen Bauabschnitten aufladen kann
- eine **Kiste bzw. ein Container** als Material-/Abfalllager
- die benötigten Baumaterialien in ausreichender Menge
- OpenOS auf dem Roboter

### Sehr empfohlen

- Tier-3-Robot bzw. möglichst leistungsfähige Robot-Hardware
- große Akku-Kapazität
- mehrere Akkus als Reserve
- zusätzliche Inventory-/Storage-Funktionen
- Navigation/Chunk-/Positionsunterstützung, sofern im verwendeten OpenComputers-Setup verfügbar
- genügend Inventarslots für verschiedene Baumaterialien
- ein stabiler, gut zugänglicher Ladepunkt

## 2. Werkzeug

Der Roboter benötigt eine für den jeweiligen Block geeignete Spitzhacke bzw. ein geeignetes Werkzeug.

Unterstützt werden sollen insbesondere:

- Vanilla-Spitzhacken
- modded Spitzhacken
- Tinkers' Construct-Werkzeuge
- Werkzeuge mit anderem Namen, z. B. Pickaxe, Hammer, Excavator, Mattock oder vergleichbare Werkzeuge
- unterschiedliche Materialien und Werkzeugtypen

Die Auswahl erfolgt nach den Informationen, die OpenComputers über den Inventory Controller zur Verfügung stellt. Eine 100%-Garantie für jedes beliebige Mod-Werkzeug ist nur möglich, wenn OpenComputers das betreffende Item korrekt als Itemstack bereitstellt.

**Empfehlung:** Slot 1 bleibt als Hauptwerkzeug reserviert.

## 3. Materiallager

Der Roboter braucht einen festen Container in der Nähe des Start-/Ladebereichs.

Der Container dient für:

- Baumaterial
- zusätzliche Werkzeuge
- Ersatzwerkzeuge
- überschüssige Items
- Abfall/Müll
- Wiederaufnahme nach einem Neustart

Der Roboter soll nicht einfach sein Inventar volllaufen lassen. Wenn Slots knapp werden, müssen überschüssige bzw. nicht benötigte Items in den vorgesehenen Container ausgelagert werden.

## 4. Ladepunkt

Der Start- und Ladepunkt muss dauerhaft erreichbar sein.

Standardmäßig wird ein **Schutzradius von 5 Blöcken** verwendet.

Innerhalb dieses Bereichs darf der Builder keine normalen Baublöcke platzieren oder unnötig abbauen.

Der Bereich soll enthalten:

- Roboter-Startposition
- Charging Point
- Materialkiste/Container
- ausreichend freie Bewegungsfläche

Der Ladepunkt darf nicht durch die SGC-Schematic zugemauert werden.

## 5. Platzierung des Roboters

Vor dem ersten Start:

1. Roboter an den vorgesehenen Startpunkt stellen.
2. Ladepunkt anschließen bzw. funktionierende Energieversorgung sicherstellen.
3. Materialcontainer erreichbar aufstellen.
4. Roboter mit Werkzeug und Baumaterial bestücken.
5. OpenOS starten.
6. Bauplan auf den Roboter übertragen.
7. Konfiguration prüfen.
8. Erst danach den Builder starten.

Der Startpunkt sollte möglichst außerhalb des eigentlichen SGC-Bauvolumens liegen.

## 6. Inventar-Empfehlung

Empfohlene Aufteilung:

| Slot | Zweck |
|---|---|
| 1 | Hauptwerkzeug / Spitzhacke |
| 2+ | Baumaterial |
| reservierte Slots | Ersatzwerkzeug / Spezialwerkzeuge |
| übrige Slots | Material und temporäre Items |

Der Roboter darf den reservierten Werkzeug-Slot nicht versehentlich für normales Baumaterial verwenden.

## 7. Energie

Bei großen SGC-Bauten ist ein einzelner kleiner Akku nicht ausreichend zuverlässig.

Empfohlen:

- großer Akku
- dauerhaft erreichbarer Charging Point
- Ladepunkt außerhalb des Bauvolumens
- gespeicherte Position des Ladepunkts
- automatische Rückkehr zum Ladepunkt bei niedrigem Energiezustand
- anschließende Fortsetzung an der letzten gespeicherten Position

Der Baufortschritt wird gespeichert, damit ein Stromausfall oder Neustart nicht den kompletten Bau zurücksetzt.

## 8. Schematic / Bauplan

Als Quellformate sind vorgesehen:

- `.schematic`
- `.schem`
- weitere Formate über zusätzliche Konverter/Loader

Der Roboter selbst verwendet für den eigentlichen Bau einen validierten, portablen `.plan`-Datensatz.

Grund:

Die klassischen `.schematic`-Dateien enthalten häufig binäre NBT-Daten und können zusätzlich komprimiert sein. OpenComputers 1.7.10 stellt nicht auf jeder Installation dieselbe NBT-/GZIP-Laufzeitumgebung bereit.

Deshalb wird empfohlen:

`schematic/schem/OBJ/sonstiges -> Konverter -> validierter .plan -> Robot`

Der `.plan` enthält unter anderem:

- Abmessungen
- Zielkoordinaten
- Standposition des Roboters
- Blickrichtung
- benötigten Slot
- Schutzbereiche
- Bau-Reihenfolge

## 9. SGC-spezifische Anforderungen

Für die geplante Stargate-SG-1-SGC-Rekonstruktion muss der Bauplan insbesondere berücksichtigen:

- begehbare Räume
- begehbare Korridore
- Treppen
- Türen und Durchgänge
- Stargate-Raum
- Control Room
- Briefing Room
- Commander's Office
- Servicebereiche
- Aufzugsschächte
- freie PneumaticCraft-Aufzugsbereiche
- keine zugemauerten Durchgänge
- definierte Wartungs-/Serviceflächen
- geschützten Robotik-/Ladebereich

Der Bauplan wird **bottom-to-top** verarbeitet, damit Fundamente und untere Ebenen zuerst entstehen.

## 10. Was der Roboter automatisch erledigen soll

Der fertige Builder soll:

- Bauplan laden
- Bauplan validieren
- Ebenen von unten nach oben bauen
- geeignete Werkzeuge auswählen
- modded Werkzeuge erkennen
- Tinkers-Werkzeuge erkennen, sofern als Itemstack verfügbar
- Materialbestand prüfen
- Material aus dem Container holen
- volle Inventarslots erkennen
- überschüssige Items auslagern
- Ladepunkt freihalten
- Schutzradius von 5 Blöcken einhalten
- Baufortschritt speichern
- nach Neustart fortsetzen
- bei Fehlern nicht blind weiterbauen
- blockierte Wege erkennen
- fehlendes Material melden
- Werkzeugverschleiß erkennen, soweit die OpenComputers-API dies liefert
- bei niedrigem Akku zum Ladepunkt zurückkehren
- nach dem Laden automatisch fortsetzen

## 11. Was nicht versprochen wird

Der Builder darf nicht so programmiert werden, dass er unbekannte Mod-Blöcke oder unbekannte Werkzeuge einfach errät und dadurch die Welt beschädigt.

Insbesondere gilt:

- unbekannte Block-ID -> Fehler/Mapping erforderlich
- unbekanntes Werkzeug -> Werkzeugprüfung
- nicht erreichbarer Block -> Bau pausieren
- fehlendes Material -> Materialanforderung
- Ladepunkt nicht erreichbar -> Bau pausieren
- ungültiger Bauplan -> nicht starten

## 12. Empfohlene Ordnerstruktur auf dem Roboter

```text
/home/sgc/
├── sgc-builder.lua
├── schematic.lua
├── navigation.lua
├── inventory.lua
├── recovery.lua
├── config.cfg
├── SGC-SG1-Cheyenne-Mountain.plan
├── build-progress.cfg
├── blocks.cfg
└── logs/
```

## 13. Konfiguration

Die wichtigsten Einstellungen befinden sich in `config.cfg`.

Dort werden unter anderem festgelegt:

- Bauplanpfad
- Fortschrittsdatei
- Startposition
- Schutzradius
- reservierte Slots
- Bewegungsversuche
- Platzierungsversuche
- Lade-/Materialposition

## 14. Vor dem ersten echten Bau

Vor dem vollständigen SGC-Bau sollte zuerst ein kleiner Testbereich gebaut werden.

Testen:

- Vorwärts-/Rückwärtsbewegung
- Drehen
- Platzieren
- Abbauen
- Werkzeugerkennung
- Inventarverwaltung
- Container ein-/auslagern
- Akku/Laden
- Fortschritt speichern
- Neustart und Resume
- Schutzradius

Erst wenn diese Tests erfolgreich sind, sollte der Roboter auf die komplette SGC-Rekonstruktion losgelassen werden.

## 15. Wichtiger Hinweis zur finalen SGC-Schematic

Die filmnahe SGC-Schematic wird nicht als fertig bezeichnet, solange die Geometrie, Ebenen, Räume, Aufzugsschächte, Durchgänge und die technische Binärdatei nicht geprüft wurden.

Es wird ausdrücklich keine leere, erfundene oder beschädigte `.schematic` als fertige SGC-Datei in das Repository gelegt.

## Status

Der Roboter ist als eigenständiges OpenComputers-Projekt angelegt. Die Hardware- und Betriebsanforderungen sind hier vollständig dokumentiert; die finale SGC-Binär-Schematic bleibt an die vorherige Geometrie-/Dateiprüfung gebunden.
