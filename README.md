# Terraria Server Container

This repository defines a container that is intended to ease upgrading of
the Terraria server versions by building a new image based on the server
version. It is bootstrapped with a bash script that uses tmux to launch
a maximum number of terraria servers.

## Build

Build the terraria image from the Dockerfile using the following command:

> Version numbers are taken from [here](https://terraria.fandom.com/wiki/Server#Downloads),
> simply remove the '.' literals from the version number. e.g. 1.4.4.9 == 1449

```shell
nerdctl build . --tag <desired tag name> --build-arg TERRARIA_VERSION=<desired version>
```

## Run

Run the terraria image using the following command, ensure to create a volume to the
directory where your `*.wld` files are:

```shell
nerdctl run -it --name <desired name> -v /path/to/worlds:/home/terraria/worlds <terraria tag name> 
```

## Useful Commands

The following command can be used to attach to the `terraria-servers` Tmux session

```shell
tmux attach-session -t terraria-servers
```

The following control sequences can be used to safely detach from the `terraria-servers` container when pressed in sequence.

```shell
1. "CTRL + P"
2. "CTRL + Q"
```
