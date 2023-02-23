#!/bin/bash

# if the game isn't installed, set to install
if [ ! -f "/game/TheForestDedicatedServer.exe" ]; then
  echo "No installation found. Installing..."
  UPDATE_SERVER=true
fi

# honor UPDATE_SERVER, which could be set outside of this script as well as above to force updates
if [ "$UPDATE_SERVER" == "true" ]; then
  set -ex
  steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /game +login anonymous +app_update 556450 validate +quit
  set +ex
fi

# start virtural x server
export WINEARCH=win64
export DISPLAY=:1.0
export WINEDLLOVERRIDES="mscoree,mshtml="
export WINEPREFIX=/root/.wine-prefix/WINE64
mkdir -p $WINEPREFIX
Xvfb :1 -screen 0 1024x768x24 & # TODO: s6 this
winecfg & # TODO: s6 this
wineboot -r

rm -rf /tmp/.X1-lock 2>/dev/null

set -ex
sleep 10

# set config 
envtemplate < /tmp/server.cfg > /game/server.cfg

# Note: "/saves" is a prefix. The actual server saves will be stored at "/savesMultiplayer"

# start the server
wine64 /game/TheForestDedicatedServer.exe \
  -batchmode \
  -dedicated \
  -savefolderpath /saves \
  -configfilepath /game/server.cfg
