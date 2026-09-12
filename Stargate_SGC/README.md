# Stargate SG-1 – SGC Cheyenne Mountain Reconstruction

Minecraft 1.7.10 / Schematica 1.7.6.131

This project is intended to become a new, walkable reconstruction of the Stargate Command (SGC) as depicted in Stargate SG-1. It is **not intended to be a simple re-upload/copy of another Minecraft map**.

## Reconstruction goals

- Cheyenne Mountain exterior and entrance
- SGC underground complex with the 28 sublevels represented in the SG-1 reference material
- show-critical Level 27 and Level 28 areas reconstructed from production/set references
- Stargate room, control room, briefing room and commander's office
- walkable corridors, stairs and service areas
- usable elevator shafts with clearance for PneumaticCraft elevators
- Minecraft 1.7.10 compatible block palette
- final `.schematic` suitable for Schematica 1.7.6.131

## Repository schematic files

The schematic/build-plan files are stored directly in this repository under `Stargate_SGC/schematic/`.

- `SGC-SG1-Cheyenne-Mountain.plan` – portable OpenComputers runtime build-plan format
- The final binary `SGC-SG1-Cheyenne-Mountain.schematic` will be added **only after the complete SGC geometry has been generated and validated**.

The `.plan` file is deliberately text-based so the OpenComputers robot can load it reliably on Minecraft 1.7.10. It is not a replacement for the final Schematica `.schematic`; both formats are intended to be supplied once the source geometry is complete.

## Robot requirements

The robot implementation is located in `Stargate_SGC/robot/` and is independent of MATRIX-OS.

Required hardware:

1. OpenComputers Tier-3 Robot
2. sufficient battery/energy capacity
3. Inventory Controller Upgrade
4. at least one suitable pickaxe/tool
5. required construction materials
6. reachable charging point
7. compatible OpenComputers charging/energy setup

Recommended for unattended construction:

- Chunk Loader Upgrade
- Navigation Upgrade
- Geolyzer Upgrade
- Wireless Network Card/modem
- material chest/container
- waste chest/container
- spare tool
- large energy reserve

The robot is designed to recognize vanilla and modded tools by Inventory Controller item data, including Tinkers' Construct tools where the installed OpenComputers integration exposes their item information.

The configured start/charging area has a default **5-block protected radius**. The robot must leave the charging position and supply/waste storage accessible and must not use that protected area as ordinary construction space.

## Reference strategy

Existing Minecraft SGC maps are used only as geometric research material. The visible SG-1 set and production references take priority where they differ from fan-made maps.

## Build-plan workflow

1. Validate the SGC source geometry.
2. Generate the complete walkable structure.
3. Export the portable `.plan` used by the OpenComputers robot.
4. Export the binary `.schematic` for Schematica 1.7.6.131.
5. Verify dimensions, palette, NBT structure and that the file can be loaded before calling the schematic finished.

## Status

The repository structure and robot/runtime plan are in place. The **final binary `.schematic` is still pending** complete geometry generation and technical validation. It is deliberately not represented as finished yet.

## Important

This is an unofficial fan reconstruction and is not an official Stargate asset.
