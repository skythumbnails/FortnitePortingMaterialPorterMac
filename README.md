<div align="center">

# FortnitePorting MP for Mac
### The Material Porter fork of FortnitePorting, on macOS (Apple Silicon)

[![macOS](https://img.shields.io/badge/macOS-Apple%20Silicon-black?logo=apple&logoColor=white)]()
[![Release](https://img.shields.io/github/release/skythumbnails/FortnitePortingMaterialPorterMac)](https://github.com/skythumbnails/FortnitePortingMaterialPorterMac/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/skythumbnails/FortnitePortingMaterialPorterMac/total?color=green)]()

</div>

---

## Installation

Download `FortnitePorting-MP-<version>-arm64.dmg` from [Releases](../../releases/latest), open it and drag
**FortnitePorting MP** into Applications.

> [!IMPORTANT]
> This is a macOS port of [kyoocreatives' Material Porter fork](https://github.com/kyoocreatives/FortnitePortingMaterialPorter),
> itself a fork of **Halfheart**'s [FortnitePorting](https://github.com/h4lfheart/FortnitePorting). The exact materials,
> effects and rigs are their work; this repository adds what it takes to run them on a Mac.

It runs beside [FortnitePorting Mac](https://github.com/skythumbnails/FortnitePortingMac): its own settings and data
(`~/Library/Application Support/FortnitePorting MP`) and its own Blender plugin (`fortnite_porting_mp`, port 40010).

## Requirements

- An Apple Silicon Mac, macOS 11 or later
- Blender 5.x for live import (tested on 5.1.1)
- Optional: VLC 3.x in Applications, for the cosmetic video previews
- Optional: `brew install vgmstream`, for sound export

## macOS Security Warning

The app is not notarized by Apple, so macOS may warn the first time you open it. Right click the app, press
**Open**, then **Open** again — or go to `System Settings → Privacy & Security → Open Anyway`.

## What's different on Mac

- **Exact materials work in On-Demand mode — no UEFN install needed.** The editor data the fork translates
  materials from ships in Fortnite's optional `.o.utoc` containers, and On-Demand mode used to skip every one of them
  (`HybridFileProvider` read `pakchunk0-WindowsClient.o.utoc` as an `o.utoc` file).
- **Effects replay on Blender 5.1.** The fork's effect replay used a Blender 5.2-only API, so on 5.1 every effect
  stayed where it was imported, at the character's feet.
- The FortnitePorting Mac patch set: native Oodle, macOS window chrome and file drag, `afplay`/`vgmstream` audio,
  the Forge V4 material option.
- Video previews use VLC.app when it is installed. The fork's updater is off (its releases are Windows builds).

## mp.13 Mac update

Includes upstream mp.13's shell fur, skin/fur subsurface settings, cleaner material graphs,
texture-size limit and compressed GPU textures, map options and older-build fixes.

Asset tabs resolve icon paths without loading every icon texture first, and package lookups reuse
a sorted archive index. In the October 7 on-demand benchmark on this Mac, Outfits fell from
about 14–16 seconds to 4–5 seconds. This measures listing, not downloading every thumbnail.
Lossless PNG export uses faster compression: identical decoded pixels, somewhat larger files.
ReadyToRun reduces first-use compilation. Network/cache state and hardware affect results.

The Mac theme, Forge V4 integration, separate Blender plugin, audio fixes and optional editor
material data remain included. The launcher now bounds runtime probes and validates its fallback.

## Known Issues

- On-Demand mode with the editor data uses about 7 GB of memory.
- With FortnitePorting Mac's plugin enabled in the same Blender, this fork's panels replace its same-named ones (as
  on Windows), and quitting Blender prints a harmless unregister error from the other plugin.

## Building from Source

```bash
git clone --recursive https://github.com/skythumbnails/FortnitePortingMaterialPorterMac
cd FortnitePortingMaterialPorterMac
macos/build-dmg.sh
```

Needs the .NET 10 SDK and the Xcode command line tools, on an APFS volume. The script lays `patches/CUE4Parse/` over
the submodule, publishes for `osx-arm64`, and writes the app and the dmg to `macos/out/`.

---

<div align="center">

# Fortnite Porting


[![Discord](https://img.shields.io/discord/866821077769781249?logo=discord&logoColor=white&label=Discord&color=7289da)](https://discord.gg/fortniteporting)
[![Blender](https://img.shields.io/badge/Blender-4.2+-blue?logo=blender&logoColor=white&color=orange)](https://www.blender.org/download/)
[![Unreal](https://img.shields.io/badge/Unreal-5.8-blue?logo=unreal-engine&logoColor=white&color=white)](https://www.unrealengine.com/en-US/download)
[![Release](https://img.shields.io/github/release/h4lfheart/FortnitePorting)](../../releases/latest)
[![Downloads](https://img.shields.io/github/downloads/h4lfheart/FortnitePorting/total?color=green)](../../releases)

<img alt="Fortnite Porting" src=".github/cover.png" />

</div>

<!-- Material Porter fork -->
> **FortnitePorting MP** is an unofficial fork: materials rebuilt from their Unreal graphs, LEGO Fortnite and
> Rocket Racing content. Download it from [Releases](../../releases/latest); what it changes is in [FORK.md](FORK.md).
> FortnitePorting's Discord and repository don't support it.

## Features

- **Browse Fortnite assets** - Explore cosmetics, props, gameplay items, and more through a purpose-built interface.
- **Export directly to creative tools** - Send assets to Blender or Unreal Engine through companion plugins managed inside the app.
- **Work with complete environments** - Export maps, actors, landscapes, foliage, and more.
- **Choose your workflow** - Use an installed copy of Fortnite or load assets through On-Demand mode.
- **Preview before exporting** - Inspect models, materials, textures, audio, and raw file properties.
- **Automate the setup** - Fetch required AES keys and mappings automatically, with configurable export settings.

## Requirements

- Windows x64
- A local Fortnite installation or On-Demand mode
- [Blender 5.0+](https://www.blender.org/download/) and/or [Unreal Engine 5.8+](https://www.unrealengine.com/en-US/download) for live import

Blender and Unreal Engine are only required when exporting directly to those applications. Assets can also be exported to a folder.

> [!NOTE]
> Community-maintained forks are available for other platforms: [FortnitePortingMac](https://github.com/skythumbnails/FortnitePortingMac) and [FortnitePorting-linux](https://github.com/fclivaz42/FortnitePorting-linux). These are not officially supported by this repository.

## Installation

Download the latest release from [GitHub Releases](../../releases/latest).

> [!IMPORTANT]
> Direct export to **Blender** and **Unreal Engine** requires their respective companion plugins. Install and manage them from the **Plugin** Tab inside Fortnite Porting.

## Quick Start

1. Download and launch `FortnitePorting.exe`.
2. Complete the initial setup using **Latest Installed**, **On-Demand**, or a **Custom** installation.
3. If exporting to Blender or Unreal Engine, install the appropriate companion plugin from the **Plugin** Tab.
4. Open the **Assets** Tab, select an item, choose an export target, and export.

## Export Targets

| Target | Details |
| --- | --- |
| **Blender** | Live import through the Fortnite Porting Blender extension |
| **Unreal Engine** | Live import through the Fortnite Porting and UEFormat plugins |
| **Assets Folder** | Offline export to the default Fortnite Porting assets directory while maintaining folder structure |
| **Custom Folder** | Offline export to a directory of your choice without maintaining folder structure |

---

## Building from Source

Fortnite Porting requires the [.NET SDK](https://dotnet.microsoft.com/download) and currently targets Windows x64.

Clone the repository with its submodules:

```sh
git clone https://github.com/h4lfheart/FortnitePorting --recursive
```

From the repository root, publish a self-contained build:

```sh
dotnet publish FortnitePorting -c Release --self-contained -r win-x64 -o "./Release" -p:PublishSingleFile=true -p:DebugType=None -p:DebugSymbols=false -p:IncludeNativeLibrariesForSelfExtract=true
```

## Links

- [Website](https://fortniteporting.app)
- [Discord](https://discord.gg/fortniteporting)
- [GitHub](https://github.com/h4lfheart/FortnitePorting)
- [X / Twitter](https://twitter.com/FortnitePorting)
- [Support on Ko-fi](https://ko-fi.com/h4lfheart)

## License

Fortnite Porting is distributed under the [GNU General Public License v3.0](LICENSE).

Fortnite Porting is an independent project and is not affiliated with, endorsed by, or sponsored by Epic Games. Fortnite and related marks are trademarks of Epic Games. You are responsible for ensuring that your use of exported assets complies with applicable licenses and terms.

---

## Contributors

- [Chippy](https://github.com/Bmarquez1997) - Material system and export feature development.
- [Ghost](https://github.com/GhostScissors) - RADA and BINKA audio decoders and asset deserialization fixes.
- [Asval](https://github.com/4sval) - Inspiration for Fortnite Porting and a primary contributor to [CUE4Parse](https://github.com/FabianFG/CUE4Parse).
- [GMatrix](https://github.com/GMatrixGames) - AES key and mapping infrastructure through UEDB.
- [Marcel](https://github.com/Ka1serM) - Unreal Engine and UEFormat plugins, world export features, and project inspiration.
- [MountainFlash](https://github.com/MinshuG) - Inspiration for the project's early automation.
- [RedHaze](https://github.com/RedHaze) - Pose Asset processing and UEFormat pose export groundwork.

Thank you to everyone who has contributed to Fortnite Porting throughout its development!!
