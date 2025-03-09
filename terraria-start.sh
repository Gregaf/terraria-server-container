#!/bin/bash

set -e

worlds_directory="/home/terraria/worlds"
max_worlds_to_load="${WORLD_MAX:-1}"  # Default to 1 if WORLD_MAX is not set
terraria_server_bin="${TERRARIA_SERVER_BIN:?TERRARIA_SERVER_BIN not set}"

base_port=8000
worlds_loaded=0

mkdir -p "$worlds_directory"

if ! compgen -G "$worlds_directory"/*.wld > /dev/null; then
    echo "No worlds found. Creating a new large world..."
    new_world_file="$worlds_directory/DefaultWorld.wld"

    "$terraria_server_bin" -world "$new_world_file" -autocreate 3 -worldname "DefaultWorld" -seed "default" -noupnp -nosteam
fi

tmux new-session -d -s terraria-servers

for world_file in "$worlds_directory"/*.wld; do
    [[ -f "$world_file" ]] || continue

    world_name=$(basename "$world_file" .wld)
    port=$((base_port++))

    tmux new-window -t terraria-servers -n "$world_name" \
        "$terraria_server_bin -world \"$world_file\" -port $port"

    ((worlds_loaded++))
    [[ "$worlds_loaded" -ge "$max_worlds_to_load" ]] && break
done

tmux attach-session -t terraria-servers