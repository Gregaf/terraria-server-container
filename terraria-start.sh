#!/bin/bash

worlds_directory="/home/terraria/worlds"

max_worlds_to_load="$WORLD_MAX"
terraria_server_bin="$TERRARIA_SERVER_BIN"

if [ ! -d "$worlds_directory" ]; then
    echo "Terraria worlds directory not found. Exiting..."
    exit 1
fi

base_port=8000
worlds_loaded=0

tmux new-session -d -s terraria-servers

for world_file in "$worlds_directory"/*.wld; do
    if [ -f "$world_file" ]; then
        world_name=$(basename -- "$world_file" .wld)
        
        port=$((base_port++))
        
        tmux new-window -t terraria-servers -n "$world_name" "$terraria_server_bin -world \"$world_file\" -port $port"
        
        # Increment the counter
        worlds_loaded=$((worlds_loaded + 1))
        
        if [ "$worlds_loaded" -ge "$max_worlds_to_load" ]; then
            break
        fi
    fi
done

tmux attach-session -t terraria-servers
