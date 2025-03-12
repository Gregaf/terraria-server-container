#!/bin/bash

set -e

worlds_directory="$HOME/.local/share/Terraria/Worlds"
terraria_server_bin="${TERRARIA_SERVER_BIN:?TERRARIA_SERVER_BIN not set}"
port=7777

mkdir -p "$worlds_directory"

existing_world=$(find "$worlds_directory" -maxdepth 1 -name "*.wld" | head -n 1)

if [[ -z "$existing_world" ]]; then
    echo "No existing world found. Creating a new large world..."
    "$terraria_server_bin" -autocreate 3 -worldname "DefaultWorld" -seed "default" -noupnp -nosteam
else
    echo "Using existing world: $existing_world"
fi

"$terraria_server_bin" -world "$existing_world" -port "$port"
