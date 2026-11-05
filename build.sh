#!/bin/sh
# Builds every plugin here into target/plugins/<name>, each the folder Ghostwrite loads,
# with ghostwrite-dev/plugin-build's build.sh: ../plugin-build/build.sh, or where
# PLUGIN_BUILD says. Their code shares one target folder, and grammars are downloaded
# once. With names, builds only those.
set -eu
cd "$(dirname "$0")"
build=${PLUGIN_BUILD:-../plugin-build/build.sh}
export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-$PWD/target}"

if [ $# -eq 0 ]; then
    set -- $(for manifest in */plugin.json; do dirname "$manifest"; done)
fi
for plugin in "$@"; do
    sh "$build" "$plugin" "target/plugins/$plugin"
done
