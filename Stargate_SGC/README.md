# Stargate SG-1 – SGC Cheyenne Mountain Reconstruction

Minecraft 1.7.10 / Schematica 1.7.6.131

This project is a new, walkable reconstruction of Stargate Command (SGC) inspired by Stargate SG-1. It is **not a re-upload of another Minecraft map**.

## Schematic files

The actual schematic files are stored in `Stargate_SGC/schematic/`:

- `SGC-SG1-Cheyenne-Mountain.schematic` – real GZIP/NBT legacy `.schematic` file, currently a compact validated SGC core layout for Minecraft 1.7.10/Schematica.
- `SGC-SG1-Cheyenne-Mountain.plan` – portable OpenComputers runtime build-plan source.

The binary `.schematic` has been generated with the legacy `Materials=Alpha`, `Width`, `Height`, `Length`, `Blocks`, `Data`, `Entities` and `TileEntities` structure and is stored as a binary Git blob rather than as text.

**Important:** this first binary is a validated **SGC core/buildable base**, not a claim that every filmed corridor and all 28 levels have already been reconstructed. The complete film-near expansion will build on this file rather than replacing it with a fake placeholder.

## Reconstruction goals

- Cheyenne Mountain exterior and entrance
- underground SGC complex with the major SG-1 areas
- Stargate room, control room, briefing room and commander's office
- walkable corridors, stairs and service areas
- clear elevator shafts suitable for PneumaticCraft elevators
- Minecraft 1.7.10 compatible block palette
- Schematica 1.7.6.131 compatible legacy `.schematic`

## Robot requirements

The robot implementation is in `Stargate_SGC/robot/` and is independent of MATRIX-OS.

### Required

1. OpenComputers Tier-3 Robot
2. sufficient battery/energy capacity
3. Inventory Controller Upgrade
4. at least one suitable pickaxe/tool
5. required construction materials
6. reachable charging point
7. compatible OpenComputers charging/energy setup

### Recommended for unattended construction

- Chunk Loader Upgrade
- Navigation Upgrade
- Geolyzer Upgrade
- Wireless Network Card/modem
- material chest/container
- waste chest/container
- spare tool
- large energy reserve

The robot is designed to recognize vanilla and modded tools from Inventory Controller item data, including Tinkers' Construct tools when the installed OC integration exposes their item information.

The configured start/charging area has a default **5-block protected radius**. Charging position and supply/waste storage remain outside ordinary construction work.

## Reference strategy

Existing Minecraft SGC maps may be used as geometric research material, but SG-1 production/set references take priority where they differ from fan-made maps.

## Build workflow

1. Validate reference geometry.
2. Generate the complete walkable structure.
3. Export/update the portable `.plan`.
4. Export/update the binary `.schematic`.
5. Verify NBT structure, dimensions, block palette and loadability before marking an expanded build finished.

## Status

The repository now contains an actual binary `.schematic` instead of the previous placeholder, plus the portable robot plan. The current binary is the validated SGC core/base; the full film-near expansion remains a separate geometry-generation step.

## Important

This is an unofficial fan reconstruction and is not an official Stargate asset.
