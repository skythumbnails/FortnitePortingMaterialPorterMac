#!/bin/bash
# Builds "FortnitePorting MP.app" and its dmg for Apple Silicon from this repo.
#
#   git submodule update --init --recursive
#   macos/build-dmg.sh [output-dir]          (default: macos/out)
#
# DOTNET=/path/to/dotnet picks the SDK (.NET 10). Build from an APFS volume: on exFAT, macOS writes
# "._*" files the compilers trip over.
set -euo pipefail

# the real path: MSBuild treats /tmp/... and /private/tmp/... as two projects and builds both at once (CS0006)
ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
OUT="${1:-$ROOT/macos/out}"
DOTNET="${DOTNET:-dotnet}"
VERSION="$(sed -n 's#.*<Version>\(.*\)</Version>.*#\1#p' "$ROOT/src/FortnitePorting/FortnitePorting.csproj" | head -1)"
BUILD="${VERSION##*.}"

# The CUE4Parse fixes this fork carries, laid over the submodule (the fork's FSpline.cs and static mesh reading, the
# Mac patch's IoChunkToc.cs and CMakeLists.txt, the lock-free file lookups and the fast PNG export)
# (by content, so a rebuild leaves the submodule untouched)
rsync -rc "$ROOT/patches/CUE4Parse/" "$ROOT/external/CUE4Parse/"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

# _EnableMacOSCodeSign=false: the hosts are signed (or not) below, on purpose
# PublishReadyToRun: the assemblies precompiled - less JIT at startup and on a tab's or an export's first run
"$DOTNET" publish "$ROOT/src/FortnitePorting/FortnitePorting.csproj" -c Release -r osx-arm64 --self-contained true \
    -p:PublishSingleFile=false -p:PublishReadyToRun=true -p:MPPrivateRoot=none/ -p:_EnableMacOSCodeSign=false -o "$WORK/publish"

APP="$WORK/stage/FortnitePorting MP.app"
CONTENTS="$APP/Contents"
RUNTIME="$CONTENTS/Resources/runtime"
mkdir -p "$CONTENTS/MacOS" "$CONTENTS/Resources"
ditto "$WORK/publish" "$RUNTIME"

# two hosts, see macos/launcher.c
cp "$RUNTIME/FortnitePorting" "$RUNTIME/FortnitePorting-unsigned"
codesign --remove-signature "$RUNTIME/FortnitePorting-unsigned" 2>/dev/null || true
clang -O2 -arch arm64 -mmacosx-version-min=11.0 -o "$CONTENTS/MacOS/FortnitePortingMPLauncher" "$ROOT/macos/launcher.c"
sed -e "s/@VERSION@/$VERSION/" -e "s/@BUILD@/$BUILD/" "$ROOT/macos/Info.plist" > "$CONTENTS/Info.plist"
cp "$ROOT/macos/AppIcon.icns" "$CONTENTS/Resources/"
find "$WORK/stage" \( -name '._*' -o -name '.DS_Store' \) -delete

# ad-hoc sign every Mach-O in the runtime except the unsigned host, then the launcher, then seal the bundle
find "$RUNTIME" -type f ! -name FortnitePorting-unsigned -print0 | while IFS= read -r -d '' f; do
    if file -b "$f" | grep -q Mach-O; then codesign --force --sign - "$f"; fi
done
codesign --force --sign - "$CONTENTS/MacOS/FortnitePortingMPLauncher"
codesign --force --sign - "$APP"
codesign --verify --deep --strict "$APP"

mkdir -p "$OUT"
rm -rf "$OUT/FortnitePorting MP.app"
ditto "$APP" "$OUT/FortnitePorting MP.app"
ln -s /Applications "$WORK/stage/Applications"
hdiutil create -volname "FortnitePorting MP" -srcfolder "$WORK/stage" -ov -format UDZO \
    "$OUT/FortnitePorting-MP-$VERSION-arm64.dmg"
echo "$OUT/FortnitePorting-MP-$VERSION-arm64.dmg"
